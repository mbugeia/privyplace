#!/bin/sh

set -eux

if [ -f /data/config.php ]
then
  cp /data/config.php /www/api/config/config.php
fi
