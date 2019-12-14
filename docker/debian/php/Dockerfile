FROM privyplace/debian:latest

USER root

ENV TIMEZONE            Europe/Paris
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M

RUN set -eux \
    && apt-get update \
    && apt-get install -y php \
                          php-fpm \
                          php-zip \
                          php-sqlite3 \
                          php-curl \
                          php-ldap \
                          php-json \
                          php-mysql \
                          php-pgsql \
                          php-xml \
                          php-xmlrpc \
                          mailutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php/7.3/fpm/php.ini \
    && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php/7.3/fpm/php.ini \
    && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php/7.3/fpm/php.ini \
    && sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php/7.3/fpm/php.ini \
    && sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php/7.3/fpm/php.ini \
    && mkdir /var/phpsession /www \
    && chown -R www-data:www-data /var/phpsession /www

COPY php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf

COPY run.sh /run.sh

USER www-data

WORKDIR /www

EXPOSE 9000

CMD ["/run.sh"]
