FROM privyplace/nginx:latest

ENV HOMER_VERSION=05bdc2680193564dbb8acbd85aa8d79eeec546f5

RUN set -eux \
    && mkdir -p /www \
    && wget -q -O /tmp/www.zip https://github.com/bastienwirtz/homer/archive/05bdc2680193564dbb8acbd85aa8d79eeec546f5.zip \
    && unzip /tmp/www.zip -d /tmp/www \
    && cp -r /tmp/www/*/* /www \
    && rm -f /tmp/www.zip \
    && chown -R www-data:www-data /www

COPY *.png /www/assets/privyplace/

COPY prerun.sh /prerun.sh

WORKDIR /www