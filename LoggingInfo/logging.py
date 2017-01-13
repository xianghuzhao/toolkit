#!/usr/bin/env python

import os, sys
import json

from daemon import runner
from bottle import route, run, request

from logdb import LogDb

run_dir = os.path.dirname(os.path.abspath(__file__))

dbname = os.path.join(run_dir, 'db/log.db')

@route('/logging')
def index():
    ldb = LogDb(dbname)
    result = ldb.get()
    return {'OK': True, 'Value': result}

@route('/new', method='POST')
def new():
    data = json.loads(request.POST.keys()[0])
    ldb = LogDb(dbname)
    ldb.insert(data)


class App():
    def __init__(self):
        self.stdin_path = '/dev/null'
        self.stdout_path = os.path.join(run_dir, 'log/out')
        self.stderr_path = os.path.join(run_dir, 'log/err')
        self.pidfile_path = os.path.join(run_dir, 'run/foo.pid')
        self.pidfile_timeout = 5

    def run(self):
        run(host='0.0.0.0', port=8497)

app = App()
daemon_runner = runner.DaemonRunner(app)
daemon_runner.do_action()
