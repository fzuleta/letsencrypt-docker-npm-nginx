#!/usr/bin/env bash
DOMAIN=domain.com

# tip, you can add more -d. ie:  -d www.domain.com

docker run --rm \
    -p "80:80" \
    -p "443:443" \
    -v $PWD/certs:/etc/letsencrypt \
    -v $PWD/certs-data:/data/letsencrypt \
    certbot/certbot \
    certonly \
    --standalone \
    --agree-tos \
    --non-interactive \
    --text \
    --rsa-key-size 4096 \
    --email hlelloworld@gmail.com \
    --expand \
    -d $DOMAIN
