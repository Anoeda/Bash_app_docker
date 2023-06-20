#!/bin/bash

docker pull nginx
CONTAINER_NAME="$(docker run -d -p 81:81 --name nginx_fast_cgi nginx)"

docker exec ${CONTAINER_NAME} apt-get update
docker exec ${CONTAINER_NAME} apt-get install -y gcc spawn-fcgi libfcgi-dev

docker cp nginx.conf ${CONTAINER_NAME}:/etc/nginx/
docker cp server.c ${CONTAINER_NAME}:/etc/nginx

docker exec ${CONTAINER_NAME} gcc /etc/nginx/server.c -l fcgi -o /etc/nginx/server 

docker exec ${CONTAINER_NAME} spawn-fcgi -p 8080 -f /etc/nginx/server

docker exec ${CONTAINER_NAME} nginx -s reload