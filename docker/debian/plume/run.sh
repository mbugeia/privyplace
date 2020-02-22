#!/bin/sh

set -eux

# plm instance new --private --domain "$BASE_URL" --name 'Privy Place' 

# plm users new --admin -n 'kate' -N 'Kate' -e 'kate@plu.me' -p toto

# diesel migration run

cp /etc/plume/.env /www/.env

exec plume
