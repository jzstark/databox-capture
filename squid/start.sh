#!/bin/bash

CONFIG=`pwd`/squid.conf

docker run --name squid -d --publish 3128:3128 \
	--volume /srv/docker/squid/cache:/var/spool/squid3 \
	--volume $CONFIG:/etc/squid3/squid.conf \
	--volume /var/log/squid3:/var/log/squid3 \
	sameersbn/squid

## Reload Squid
# docker kill -s HUP squid

## Linux Client: in .bashrc:

#export ftp_proxy=http://172.17.42.1:3128
#export http_proxy=http://172.17.42.1:3128
#export https_proxy=http://172.17.42.1:3128

## Logs:
# docker exec -it squid tail -f /var/log/squid3/access.log

## Shell Access:
# docker exec -it squid bash
