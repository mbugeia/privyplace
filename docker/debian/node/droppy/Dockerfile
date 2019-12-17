FROM privyplace/node:latest

USER root

COPY config.json /tmp/config.json

COPY run.sh /run.sh

RUN set -eux \
    && npm install -g --production droppy \
    && mkdir -p /data/files /data/config \
    && chown -R www-data:www-data /data 

USER www-data

EXPOSE 8989

CMD ["/run.sh"]
