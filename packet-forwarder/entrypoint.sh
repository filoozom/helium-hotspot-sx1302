#!/bin/sh
# Copy the configuration file for the selected region
if [ -z $REGION ]
then
    echo "No region configured, set the REGION environment variable."
    exit 1
fi

if [[ ! -f "./config/$REGION.json" ]]
then
    echo "Invalid region selected. Available options:"
    ls -1a config/*.json | sed -n -e 's/^.*\/\([^.]*\).*$/- \1/p'
    exit 2
fi

cp "./config/$REGION.json" global_conf.json

# Start the concentrator
./reset_lgw.sh start

# Start the forwarder
./forwarder
