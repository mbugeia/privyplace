FROM privyplace/debian:latest

USER root

RUN set -eux \
    && apt-get update \
    && apt-get install -y nodejs \
                          npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && npm i npm@latest -g

USER www-data

CMD ["node"]
