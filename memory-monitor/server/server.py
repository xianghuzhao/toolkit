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
    name = db.Column(db.String)

    def __init__(self, name):
        self.name = name

class Mem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    mem = db.Column(db.Integer)
    created_at = db.Column(db.DateTime)

    proc_id = db.Column(db.Integer, db.ForeignKey('proc.id'))
    proc = db.relationship('Proc',
        backref=db.backref('mems', lazy='dynamic'))

    def __init__(self, mem, proc, created_at=None):
        self.mem = mem
        self.proc = proc
        if created_at is None:
            created_at = datetime.datetime.utcnow()
        self.created_at = created_at


@app.route("/")
def hello():
    return "Hello World!"

@app.route("/proc", methods=['POST'])
def proc():
    p = Proc(request.form.get('name'))
    db.session.add(p)
    db.session.commit()
    return str(p.id)

@app.route("/mem", methods=['POST'])
def mem():
    mem = request.form.get('mem')
    proc_id = request.form.get('proc_id')
    created_at = request.form.get('created_at')

    p = Proc.query.get(proc_id)
    m = Mem(mem, p, created_at)
    db.session.add(m)
    db.session.commit()
    return str(m.id)

@app.route("/procs", methods=['GET'])
def procs():
    p = Proc.query.all()
    return jsonify([{'id':i.id, 'name':i.name} for i in p])

@app.route("/mems", methods=['GET'])
def mems():
    m = Mem.query.all()
    return jsonify([{'id':i.id, 'mem':i.mem, 'proc_id':i.proc_id, 'created_at': i.created_at} for i in m])

if __name__ == "__main__":
    db.create_all()
    app.run(host='0.0.0.0', port='9191')
