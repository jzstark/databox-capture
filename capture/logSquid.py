#!/usr/bin/python

from pymongo import MongoClient
from logwatcher import LogWatcher
import datetime
import json

header = ["time", "duration", "client_addr", "result_code", "bytes", "req_method", "URL", "user", "hier_code", "type"]
COL = len(header)

client = MongoClient('localhost', 27017)
db = client.squid
accesslog = db.accesslog

def callback(filename, lines):
    for line in lines:
	rec = list(line.split())
	if len(rec) != COL : continue
        record = dict(zip(header, rec))
	# print json.dumps(record, indent=2)
	result = accesslog.insert_one(record)
	print result.inserted_id

lw = LogWatcher("/var/log/squid3", callback)
lw.loop()
