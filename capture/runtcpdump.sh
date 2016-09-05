#!/bin/bash

# WARNING: L2TP container has to be started last for this one-liner to work correctly!!!
INTERFACE=$(sudo grep "docker0: port" /var/log/syslog | tail -n 1 |  sed -r s/^.*\(veth[^\)]+\).*$/\\1/)
# tcpdump -i $INTERFACE -s0 -nn -C 1 -W10 -w 'vpnlog.pcap' -z `pwd`/capture.py -Z root
sudo tcpdump -i $INTERFACE -s0 -nn -C 5 -W10 -w /var/log/vpn/vpnlog.pcap -Z root
