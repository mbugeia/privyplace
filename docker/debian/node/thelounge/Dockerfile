FROM privyplace/node:latest

USER root

RUN set -eux \
    && yarn global add thelounge \
    && mkdir -p /var/www \
    && chown -R www-data:www-data /var/www

USER www-data

CMD ["thelounge", "start", "--config", "public=true"]
