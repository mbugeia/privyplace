FROM privyplace/nginx:latest

ENV PORTAL_VERSION=ecfb3df0e7f711da29de9c360c5fa64cc6f08815

RUN set -eux \
    && mkdir -p /www \
    && wget -q -O /tmp/www.zip https://github.com/mbugeia/privyplace-portal/archive/${PORTAL_VERSION}.zip \
    && unzip /tmp/www.zip -d /tmp/www \
    && cp -r /tmp/www/*/* /www \
    && rm -f /tmp/www.zip \
    && chown -R www-data:www-data /www

WORKDIR /www