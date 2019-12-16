#! /bin/sh

set -eux

while [ ! -f /www/app/actualize_script.php ]
do
  sleep 1
done

while :
do
  /usr/bin/php /www/app/actualize_script.php
  sleep 600
done
