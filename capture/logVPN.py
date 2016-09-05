#!/usr/bin/python

from pymongo import MongoClient
import pyinotify
import json
import pyshark
import sys

# filename = sys.argv[1]
header = ["time", "dst_addr", "dstport", "lat", "lon", "src_addr","byte"]

client = MongoClient('localhost', 27017)
db = client.l2tp
# vpnlog = db.vpnlog
vpnlog = db.test

class EventHandler(pyinotify.ProcessEvent):
    #def process_IN_CLOSE_WRITE(self, event):
    #    print "Modifying: ", event.pathname
    
    def process_IN_CREATE(self, event):
        filename = event.pathname
        print "Storing:", event.pathname
        cap = pyshark.FileCapture(filename, display_filter='tcp')
        for pkt in cap:
            try:
                time = pkt.sniff_time
                dstaddr = pkt.ip.dst
                dstport = pkt.tcp.dstport
                lat = pkt.ip.geodst_lat
                lon = pkt.ip.geodst_lon
                srcaddr = pkt.ip.src_host
                byte = pkt.length

                rec = [time, dstaddr, dstport, lat, lon, srcaddr, byte]
                record = dict(zip(header, rec))
                result = vpnlog.insert_one(record)
            except:
                pass 

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
