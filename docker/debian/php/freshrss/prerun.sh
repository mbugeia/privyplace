#! /bin/sh

set -eux

INSTALL_FLAG="/www/data/installed"

if [ ! -f "$INSTALL_FLAG" ]
then

  ./cli/prepare.php

  ./cli/do-install.php --default_user $FRESHRSS_USER --auth_type none --environment production --base_url https://$FRESHRSS_DOMAIN/ --language $FRESHRSS_LANGUAGE --title FreshRSS --api_enabled --db-type pgsql --db-host postgres.db --db-user freshrss --db-password $FRESHRSS_DB_PASSWORD --db-base freshrss --db-prefix freshrss_

  ./cli/create-user.php --user $FRESHRSS_USER --language $FRESHRSS_LANGUAGE

  grep "salt" /www/data/config.php | awk '{ print $3 }' | tr -d "'" | tr -d "," > "$INSTALL_FLAG"

fi

rm -f /www/data/do-install.txt
