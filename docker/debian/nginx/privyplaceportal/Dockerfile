FROM privyplace/nginx:latest

ENV PORTAL_VERSION=865606d4ef26392bf28f8433f13fa516053d00b5

RUN set -eux \
    && mkdir -p /www \
    && wget -q -O /tmp/www.zip https://github.com/mbugeia/privyplace-portal/archive/${PORTAL_VERSION}.zip \
    && unzip /tmp/www.zip -d /tmp/www \
    && cp -r /tmp/www/*/* /www \
    && rm -f /tmp/www.zip \
    && chown -R www-data:www-data /www

WORKDIR /www