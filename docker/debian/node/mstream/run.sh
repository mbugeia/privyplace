#!/bin/sh

set -eux

mkdir -p /data/album-art /data/db /data/logs

secret=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 32)

sed -i 's/SECRET_TO_REPLACE/'$secret'/g' /etc/mstream/config.json

exec mstream -j /etc/mstream/config.json