#!/usr/bin/env python

import urllib
import json
import time

host = 'http://172.16.100.1:8497'
action = 'new'
data = {'job_id': 12345, 'site': 'BES.WHU.cn', 'hostname': 'lololo', 'app_status': 'Simulation', 'time': time.time()}

url = '%s/%s' % (host, action)

print urllib.urlencode(data)
#urllib.urlopen(url, urllib.urlencode(data))
urllib.urlopen(url, json.dumps(data))
