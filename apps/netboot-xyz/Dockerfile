# From netboot xyz builder:
# https://github.com/netbootxyz/netboot.xyz/blob/d09dd3916c6fff7914e096b9dd64c84d309dc24f/Dockerfile

FROM ubuntu:24.04@sha256:72297848456d5d37d1262630108ab308d3e9ec7ed1c3286a32fe09856619a782

ENV DEBIAN_FRONTEND=noninteractive

# renovate: datasource=pypi depName=ansible
ARG ANSIBLE_VERSION=11.4.0

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

FROM nginx:1.27-alpine@sha256:4ff102c5d78d254a6f0da062b3cf39eaf07f01eec0927fd21e219d0af8bc0591
COPY --from=0 /output /usr/share/nginx/html
