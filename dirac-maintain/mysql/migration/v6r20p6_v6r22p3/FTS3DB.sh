#!/bin/bash

cd $(dirname "$0")

source /opt/dirac/bashrc

python AddGUIDtoFTS3File.py -c y
