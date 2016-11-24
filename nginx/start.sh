#!/bin/sh
DIR=`pwd`

docker run --name nginx -p 80:80 -v $DIR/html:/usr/share/nginx/html -v $DIR/default.conf:/etc/nginx/conf.d/default.conf -d nginx:alpine

