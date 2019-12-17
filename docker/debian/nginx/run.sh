#!/bin/sh

set -eux

if [ -f /prerun.sh ]
then
  sh /prerun.sh
fi

exec nginx