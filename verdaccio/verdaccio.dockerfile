# Due to a permissions issue when sharing VOLUMES
# on the official node image, I've used mhart/alpine-node:latest
# to run this container as root (not as node user). 

FROM mhart/alpine-node:latest

RUN apk --no-cache add ca-certificates wget curl dumb-init

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && \
    apk add glibc-2.28-r0.apk

RUN npm config set unsafe-perm true && \
    apk add --no-cache --virtual .gyp \
        python \
        make \
        g++ \
    && npm install -g verdaccio \
    && apk del .gyp

ENV PORT 4873
# ENV PROTOCOL http
ENV PROTOCOL https

EXPOSE $PORT

RUN mkdir -p /verdaccio/storage /verdaccio/conf
VOLUME [ "/verdaccio/conf", "/verdaccio/storage" ]
VOLUME [ "/etc/letsencrypt", "/data/letsencrypt" ]

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD verdaccio --config /verdaccio/conf/config.yaml --listen $PROTOCOL://0.0.0.0:${PORT}