FROM privyplace/debian:latest

USER root

RUN set -eux \
    && apt-get update \
    && apt-get install -y nginx-extras \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

COPY nginx.conf /etc/nginx/nginx.conf

COPY run.sh /run.sh

CMD ["/run.sh"]
