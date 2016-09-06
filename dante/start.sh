#!/bin/bash
PWD=`pwd`
LOG=/var/log/dante

#-v $LOG:$LOG \
docker run --name dante -d -p 1080:1080 \
	-v $PWD/sockd.conf:/etc/sockd.conf:ro \
	-v $LOG:$LOG:rw \
	vimagick/dante

# Generate PAC file
serverip=`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'`
cat > dante.pac << EOF
function FindProxyForURL(url, host){
    return "SOCKS $serverip:1080";
}
EOF
