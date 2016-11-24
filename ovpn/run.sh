#!/bin/bash
# Set up Certificate Store
OVPN_DATA="ovpn-data"
IFACE=eth0
docker run --name $OVPN_DATA -v /etc/openvpn busybox

# Userinput: wlan0 or eth0
IP=`/sbin/ifconfig $IFACE | awk '/inet addr/{print substr($2,6)}'`
docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u udp://$IP:1194
docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn ovpn_initpki

# Run OpenVPN
docker run --name ovpn --volumes-from ovpn-data -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
