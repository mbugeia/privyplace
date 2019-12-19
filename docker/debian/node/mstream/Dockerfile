FROM privyplace/node:latest

USER root

ENV MSTREAM_VERSION=4.6.0

COPY config.json /etc/mstream/config.json

RUN set -eux \
    && npm install -g mstream@${MSTREAM_VERSION} \
    && mkdir -p /data /music /var/www \
    && chown -R www-data:www-data /data /music /var/www /etc/mstream

COPY run.sh /run.sh

WORKDIR /var/www

USER www-data

EXPOSE 3000

CMD ["/run.sh"]
