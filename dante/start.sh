#!/bin/bash
PWD=`pwd`
LOG=/var/log/dante

#-v $LOG:$LOG \
docker run --name dante -d -p 1080:1080 \
	-v $PWD/sockd.conf:/etc/sockd.conf:ro \
	-v $LOG:$LOG:rw \
	vimagick/dante
