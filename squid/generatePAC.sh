#!/bin/bash
serverip=`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'`

cat > squid.pac << EOF
function FindProxyForURL(url, host){
    return "PROXY $serverip:3128";
}
EOF
