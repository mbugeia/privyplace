FROM privyplace/php:latest

ENV ORGANIZR_VERSION=v2-master

RUN set -eux \
    && wget -q -O /tmp/www.zip https://github.com/causefx/Organizr/archive/"$ORGANIZR_VERSION".zip

COPY prerun.sh /prerun.sh
COPY prestop.sh /prestop.sh