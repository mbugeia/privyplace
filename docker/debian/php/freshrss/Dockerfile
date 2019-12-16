FROM privyplace/php:latest

ENV FRESHRSS_VERSION=1.15.3

RUN set -eux \
    && wget -q -O /tmp/www.tar.gz https://github.com/FreshRSS/FreshRSS/archive/${FRESHRSS_VERSION}.tar.gz

COPY prerun.sh /prerun.sh
COPY cron.sh /cron.sh

