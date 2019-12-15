FROM privyplace/debian:latest

ENV SEARX_VER=v0.15.0

WORKDIR /www

USER root

RUN set -eux \
    && groupadd --gid 8000 searx \
    && useradd --comment 'searx user' --create-home --home-dir /home/searx --uid 8000 --gid 8000 --shell /bin/sh searx \
    && wget -q -O /tmp/www.tar.gz https://github.com/asciimoo/searx/archive/${SEARX_VER}.tar.gz \
    && tar xzfv /tmp/www.tar.gz --strip-components=1 -C /www \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get -y -q dist-upgrade \
    && apt-get install -y \
                       python3-pip \
                       uwsgi \
                       uwsgi-plugin-python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER searx

RUN set -eux \
    && pip3 install --no-cache -r /www/requirements.txt

EXPOSE 8080

CMD [ "uwsgi", "--uid", "searx", \
               "--gid", "searx", \
               "--workers", "1", \
               "--single-interpreter", \
               "--master", \
               "--lazy-apps", \
               "--enable-threads", \
               "--plugins", "python3", \
               "--wsgi", "searx.webapp", \
               "--http-socket", "0.0.0.0:8080"]
