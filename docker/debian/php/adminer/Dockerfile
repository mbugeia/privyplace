FROM privyplace/php:latest

ENV ADMINER_VERSION=4.7.5

RUN set -eux \
    && wget -q -O /www/index.php https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php

