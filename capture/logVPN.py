#!/usr/bin/python


from pymongo import MongoClient
from pktprint import *
import dpkt
import pyinotify
import json
import pyshark
import sys
import datetime

# filename = sys.argv[1]
header = ["time", "src_addr", "src_port", "dst_addr", "dst_port", "length", "http_request"]

client = MongoClient('localhost', 27017)
db = client.l2tp
vpnlog = db.vpnlog

class EventHandler(pyinotify.ProcessEvent):

    def process_IN_CREATE(self, event):
        # Use capturing HTTP requests as an example
        filename = event.pathname
        print "Storing: ", filename
        pcap = dpkt.pcap.Reader(open(filename))
        for ts, pkt in pcap: 
            eth = dpkt.ethernet.Ethernet(pkt)
            if not isinstance(eth.data, dpkt.ip.IP):
                print 'Non IP Packet type not supported %s\n' % eth.data.__class__.__name__
                continue
            ip = eth.data
            if isinstance(ip.data, dpkt.tcp.TCP):
                tcp = ip.data
                try:
                    request = dpkt.http.Request(tcp.data)
                except (dpkt.dpkt.NeedData, dpkt.dpkt.UnpackError):
                    continue
                do_not_fragment = bool(ip.off & dpkt.ip.IP_DF)
                more_fragments = bool(ip.off & dpkt.ip.IP_MF)
                fragment_offset = ip.off & dpkt.ip.IP_OFFMASK
                
                srcaddr = inet_to_str(ip.src)
                srcport = tcp.sport
                dstaddr = inet_to_str(ip.dst)
                dstport = tcp.dport 
                pktlen = len(pkt)
                httpreq = repr(request)

                data = [ts, srcaddr, srcport, dstaddr, dstport, pktlen, httpreq]
                record = dict(zip(header, data))
                # print record
                result = vpnlog.insert_one(record)
                # print 'Timestamp: ', str(datetime.datetime.utcfromtimestamp(ts))
                # print 'Ethernet Frame: ', mac_addr(eth.src), mac_addr(eth.dst), eth.type
                #print 'IP: %s -> %s   (len=%d ttl=%d DF=%d MF=%d offset=%d)' % \
                #                  (inet_to_str(ip.src), inet_to_str(ip.dst), ip.len, ip.ttl, do_not_fragment, more_fragments, fragment_offset)
                #print 'HTTP request: %s\n' % repr(request)

    process_IN_CLOSE_WRITE = process_IN_CREATE

handler = EventHandler()
mask = pyinotify.IN_CREATE | pyinotify.IN_CLOSE_WRITE

wm = pyinotify.WatchManager()
notifier = pyinotify.Notifier(wm, handler)
wm.add_watch('/var/log/vpn/', mask, rec=True)

try:
    notifier.loop(daemonize=False) #pid_file='/tmp/pyinotify.pid'
except pyinotify.NotifierError, err:
    print >> sys.stderr, err
