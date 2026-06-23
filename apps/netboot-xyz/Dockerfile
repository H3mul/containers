# From netboot xyz builder:
# https://github.com/netbootxyz/netboot.xyz/blob/d09dd3916c6fff7914e096b9dd64c84d309dc24f/Dockerfile

FROM ubuntu:26.04@sha256:53958ec7b67c2c9355df922dd08dbf0360611f8c3cdb656875e81873db9ffdba

ENV DEBIAN_FRONTEND=noninteractive

# renovate: datasource=pypi depName=ansible
ARG ANSIBLE_VERSION=14.1.0

RUN \
    apt-get update && \
    apt-get install -y \
    apache2 \
    binutils-dev \
    binutils-aarch64-linux-gnu \
    build-essential \
    dosfstools \
    figlet \
    gcc-aarch64-linux-gnu \
    genisoimage \
    git \
    isolinux \
    liblzma-dev \
    libslirp-dev \
    python3-pip \
    python3-setuptools \
    syslinux \
    syslinux-common \
    jq \
    zip \
    wget \
    curl \
    gettext-base \
    toilet

RUN pip3 install ansible==${ANSIBLE_VERSION} --break-system-packages

# From linuxserver image:
# https://github.com/linuxserver/docker-netbootxyz/blob/03cbacdade5f81870d71d10a91c065237ed5665d/Dockerfile

ARG VERSION

RUN wget https://api.github.com/repos/netbootxyz/netboot.xyz/zipball/${VERSION} -O repo.zip && \
    unzip repo.zip && \
    mv netbootxyz-netboot.xyz-* /app && \
    ls -la /app

WORKDIR /app/

COPY user_overrides.yml /app/user_overrides.yml

ARG BOOT_DOMAIN

RUN [ ! -z ${BOOT_DOMAIN} ] && \
    BOOT_DOMAIN=${BOOT_DOMAIN} envsubst < /app/user_overrides.yml > /app/user_overrides.subst.yml && \
    mv /app/user_overrides.subst.yml /app/user_overrides.yml

RUN ansible-playbook site.yml -i inventory

FROM nginx:1.31-alpine@sha256:1a8724a52d432501548a8d8681bb1554c2d09778f8b9ed0882fc3442549980b7
COPY --from=0 /output /usr/share/nginx/html
