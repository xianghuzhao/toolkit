#!/usr/bin/env python

import os
import datetime

from flask import Flask
from flask import request
from flask import jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

current_path = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(current_path, 'mem.db')
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s'%db_path
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
db = SQLAlchemy(app)

class Proc(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    vmid = db.Column(db.String, index=True)
    hostname = db.Column(db.String, index=True)
    pid = db.Column(db.Integer, index=True)
    created_at = db.Column(db.DateTime)

    def __init__(self, vmid, hostname, pid, created_at=None):
        self.vmid = vmid
        self.hostname = hostname
        self.pid = pid
        if created_at is None:
            created_at = datetime.datetime.utcnow()
        self.created_at = created_at

class Mem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    rss = db.Column(db.Integer)
    uss = db.Column(db.Integer)
    swap = db.Column(db.Integer)
    created_at = db.Column(db.DateTime)

    proc_id = db.Column(db.Integer, db.ForeignKey('proc.id'))
    proc = db.relationship('Proc',
        backref=db.backref('mems', lazy='dynamic'))

    def __init__(self, proc, rss, uss, swap, created_at=None):
        self.proc = proc
        self.rss = rss
        self.uss = uss
        self.swap = swap
        if created_at is None:
            created_at = datetime.datetime.utcnow()
        self.created_at = created_at


@app.route("/")
def hello():
    return "Hello World!"

@app.route("/proc", methods=['POST'])
def proc():
    vmid = request.form.get('vmid')
    hostname = request.form.get('hostname')
    pid = int(request.form.get('pid'))
    created_at = request.form.get('created_at')

    p = Proc(vmid, hostname, pid, created_at)
    db.session.add(p)
    db.session.commit()
    return str(p.id)

@app.route("/mem", methods=['POST'])
def mem():
    proc_id = request.form.get('proc_id')
    rss = request.form.get('rss')
    uss = request.form.get('uss')
    swap = request.form.get('swap')
    created_at = request.form.get('created_at')

    p = Proc.query.get(proc_id)
    m = Mem(p, rss, uss, swap, created_at)
    db.session.add(m)
    db.session.commit()
    return str(m.id)

@app.route("/procs", methods=['GET'])
def procs():
    p = Proc.query.all()
    return jsonify([{'id':i.id, 'vmid':i.vmid, 'hostname':i.hostname, 'pid':i.pid, 'created_at':i.created_at} for i in p])

@app.route("/findproc", methods=['GET'])
def findproc():
    vmid = request.args.get('vmid')
    hostname = request.args.get('hostname')
    pid = int(request.args.get('pid'))
    p = Proc.query.filter_by(vmid=vmid, hostname=hostname, pid=pid).first()
    if p is None:
        return 'unknown'
    return str(p.id)

@app.route("/mems", methods=['GET'])
def mems():
    m = Mem.query.all()
    return jsonify([{'id':i.id, 'proc_id':i.proc_id, 'rss':i.rss, 'uss':i.uss, 'swap':i.swap, 'created_at':i.created_at} for i in m])

if __name__ == "__main__":
    db.create_all()
    app.run(host='0.0.0.0', port='9191')
