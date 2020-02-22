FROM privyplace/debian:latest

USER root

ENV PLUME_VERSION=0.3.0-alpha-2

RUN set -eux \
    && apt-get update \
    && apt-get install -y \
                       libpq5 \
                       libssl1.1 \
                       libsqlite3-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q -O /tmp/www.tar.gz https://github.com/Plume-org/Plume/releases/download/${PLUME_VERSION}/plume-postgres.tar.gz \
    && mkdir -p /www/search_index \
    && chown -R www-data:www-data /www \
    && tar xzfv /tmp/www.tar.gz -C /www \
    && mv /www/bin/* /usr/local/bin \
    && rm -f /tmp/www.tar.gz

COPY run.sh /run.sh

USER www-data

WORKDIR /www

EXPOSE 7878

CMD ["/run.sh"]
