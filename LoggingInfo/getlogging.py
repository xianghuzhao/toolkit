#!/usr/bin/env python

import urllib
import json
import datetime

host = 'http://172.16.100.1:8497'
action = 'logging'

url = '%s/%s' % (host, action)

result = json.loads(urllib.urlopen(url).read())
if result['OK']:
    for line in result['Value']:
        print line[1], line[2], line[3], line[4], datetime.datetime.utcfromtimestamp(line[5]).strftime("%Y-%m-%d %H:%M:%S")
