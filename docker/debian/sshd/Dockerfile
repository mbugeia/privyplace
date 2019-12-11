FROM privyplace/debian:latest

USER root

COPY run.sh /run.sh

RUN set -eux \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get -y -q dist-upgrade \
    && apt-get install -y \
                       openssh-server \
                       python3 \
                       python3-psycopg2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /run.sh \
    && mkdir -p /run/sshd

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

CMD ["/run.sh"]
