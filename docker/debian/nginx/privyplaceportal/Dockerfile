FROM privyplace/nginx:latest

ENV PORTAL_VERSION=35b33bc6dbf99ac421c170af9164519fbb9575a0

RUN set -eux \
    && mkdir -p /www \
    && wget -q -O /tmp/www.zip https://github.com/mbugeia/privyplace-portal/archive/${PORTAL_VERSION}.zip \
    && unzip /tmp/www.zip -d /tmp/www \
    && cp -r /tmp/www/*/* /www \
    && rm -f /tmp/www.zip \
    && chown -R www-data:www-data /www

WORKDIR /www