#!/bin/sh

set -eux

# Copy droppy config to the volume
cp -f /tmp/config.json /data/config/config.json

exec droppy start --color -c /data/config -f /data/files