#!/bin/sh

set -eux

if [ -f /tmp/www.tar.gz ]
then
  tar xzfv /tmp/www.tar.gz --strip-components=1 -C /www
  rm -f /tmp/www.tar.gz
elif [ -f /tmp/www.zip ]
then
  unzip /tmp/www.zip -d /tmp/www
  cp -r /tmp/www/*/* /www
  rm -f /tmp/www.zip
fi

if [ -f /prerun.sh ]
then
  sh /prerun.sh
fi

exec /usr/sbin/php-fpm7.3 -R