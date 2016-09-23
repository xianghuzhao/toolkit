#!/usr/bin/env python

import time
import socket
import re

import psutil
import requests

URL = 'http://badger01.ihep.ac.cn:9191'

def findMokka():
    mems = {}
    for proc in psutil.process_iter():
        try:
            pinfo = proc.as_dict(attrs=['pid', 'name'])
            minfo = proc.memory_full_info()
        except (psutil.NoSuchProcess, psutil.AccessDenied):
            pass
        else:
            if 'Mokka' in pinfo['name']:
               mems[pinfo['pid']] = minfo
    return mems

def get_vmid():
    try:
        with open('/opt/dirac/etc/dirac.cfg') as f:
            match = re.search('^\s*VMID\s*=\s*(.*)\s*$', f.read(), re.M)
            if match:
                return match.group(1)
    except:
        pass
    return 'unknown'

def get_hostname():
    return socket.gethostname()

def main():
    vmid = get_vmid()
    hostname = get_hostname()

    proc_ids = {}
    while True:
        mems = findMokka()
        for pid, mem in mems.items():
            cond = {'vmid':vmid, 'hostname':hostname, 'pid':str(pid)}

            if pid not in proc_ids:
                response = requests.get(URL + '/findproc', params=cond)
                if response.text == 'unknown':
                    response = requests.post(URL + '/proc', data=cond)
                proc_ids[pid] = int(response.text)

            mem_info = {'proc_id': proc_ids[pid], 'rss': mem.rss/1024, 'uss': mem.uss/1024, 'swap': mem.swap/1024}
            response = requests.post(URL + '/mem', data=mem_info)
        time.sleep(30)

if __name__ == "__main__":
    main()
