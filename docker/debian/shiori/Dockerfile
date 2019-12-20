FROM privyplace/debian:latest

USER root

ENV SHIORI_VERSION=v1.5.0

ENV SHIORI_DIR="/data"

RUN set -eux \
    && wget -q -O /usr/local/bin/shiori https://github.com/go-shiori/shiori/releases/download/${SHIORI_VERSION}/shiori-linux-amd64  \
    && chmod +x /usr/local/bin/shiori \
    && mkdir -p /data \
    && chown -R www-data:www-data /data 

USER www-data

WORKDIR /data

EXPOSE 8080

CMD ["shiori", "serve"]
