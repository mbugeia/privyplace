FROM privyplace/nginx:latest

ENV HUGO_VERSION=0.61.0

RUN set -eux \
    && wget -q -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v"$HUGO_VERSION"/hugo_"$HUGO_VERSION"_Linux-64bit.deb \
    && dpkg -i /tmp/hugo.deb \
    && mkdir -p /www/public \
    && chown -R www-data:www-data /www/

WORKDIR /www

COPY prerun.sh /prerun.sh

