# From netboot xyz builder:
# https://github.com/netbootxyz/netboot.xyz/blob/d09dd3916c6fff7914e096b9dd64c84d309dc24f/Dockerfile

FROM ubuntu:24.04@sha256:728785b59223d755e3e5c5af178fab1be7031f3522c5ccd7a0b32b80d8248123

ENV DEBIAN_FRONTEND=noninteractive

# renovate: datasource=pypi depName=ansible
ARG ANSIBLE_VERSION=12.1.0

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

FROM nginx:1.29-alpine@sha256:681f39378fc752af9aa9d884e8726fe3be9658550ad233c400b3955345d23ec7
COPY --from=0 /output /usr/share/nginx/html
