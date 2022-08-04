#!/bin/bash

cd ../scripts

# Build dockers
./build_all_dockers.sh

# Set up python environment
python3 -m pip install -r ../maze-gen/requirements.txt
