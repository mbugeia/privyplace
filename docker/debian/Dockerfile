FROM debian:buster-slim

LABEL description="Base image" \
      version="1"

ENV DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8

RUN set -eux \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get -y -q dist-upgrade \
    && apt-get install -y \
                       tar \
                       dumb-init \
                       ca-certificates \
                       apt-transport-https \
                       curl \
                       less \
                       jq \
                       zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY .zshrc /etc/skel/.zshrc 
COPY .zshrc /root/.zshrc

ENV SHELL /bin/zsh

USER nobody

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["zsh"]
