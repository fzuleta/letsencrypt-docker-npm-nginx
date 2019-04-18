#!/usr/bin/env bash

docker-compose stop

./ssl_gen.sh

docker-compose up -d
