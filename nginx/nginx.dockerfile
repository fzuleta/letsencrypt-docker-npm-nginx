FROM nginx:latest

ARG DOMAIN
ARG DOCKER_PORT
ARG REGISTRY_USER
ARG REGISTRY_PASSWORD

COPY ./default_pre.conf /default_pre.conf
COPY ./default.conf /default.conf
COPY ./entrypoint.sh /entrypoint.sh

RUN echo "$REGISTRY_USER:{PLAIN}$REGISTRY_PASSWORD" > /etc/nginx/conf.d/registry.password && \
    mkdir /etc/letsencrypt && \
    mkdir /data && \
    mkdir /data/letsencrypt && \
    sed -i "s/@DOCKER_PORT@/${DOCKER_PORT}/g" /default.conf && \
    sed -i "s/@DOMAIN@/${DOMAIN}/g" /default.conf && \
    chmod +x /entrypoint.sh

VOLUME ["/etc/letsencrypt", "/data/letsencrypt"]

CMD [ "/entrypoint.sh" ]