#!/bin/bash

cd $(dirname "$0")

source /opt/dirac/bashrc

./AddGUIDtoFTS3File.py -c y
