#!/bin/sh

set -eux

if [ -f /data/config.php ]
then
  ln -s /data/config.php /www/api/config/config.php
fi
