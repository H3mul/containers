# Copied from onedr0p:
# https://github.com/onedr0p/containers/blob/de2b6e8c3c4c5bc4d74b87e9b62c4c698e3cbed2/apps/home-assistant/Dockerfile



FROM docker.io/library/python:3.13.5-alpine@sha256:37b14db89f587f9eaa890e4a442a3fe55db452b69cca1403cc730bd0fbdc8aaf
ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    HOMEASSISTANT_WHEELS="https://wheels.home-assistant.io/musllinux/" \
    HOME="/config" \
    UV_SYSTEM_PYTHON=true

ENV UMASK="0002" \
    TZ="Etc/UTC"

USER root
WORKDIR /app

#hadolint ignore=DL3018,DL3013,DL3059,DL4006
RUN \
    apk add --no-cache \
        bash \
        binutils \
        bluez \
        bluez-deprecated \
        bluez-libs \
        ca-certificates \
        catatonit \
        cups-libs \
        curl \
        eudev-libs \
        ffmpeg \
        git \
        iputils \
        jq \
        libcap \
        libjpeg-turbo-dev \
        libpcap-dev \
        libstdc++ \
        libxslt \
        mariadb-connector-c \
        mariadb-connector-c-dev \
        nano \
        openssh-client \
        openssl \
        postgresql-libs \
        socat \
        tiff \
        tzdata \
        unzip \
    && \
    apk add --no-cache --virtual=.build-deps \
        autoconf \
        build-base \
        cargo \
        cmake \
        cups-dev \
        eudev-dev \
        ffmpeg-dev \
        glib-dev \
        jpeg-dev \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        postgresql-dev \
        unixodbc-dev \
    && \
    pip install uv \
    && \
    curl -fsSL "https://github.com/home-assistant/core/archive/${VERSION}.tar.gz" \
        | tar xzf - -C /tmp --strip-components=1 \
    && \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') \
            export ARCH='amd64'; \
        ;; \
        'linux/arm64') \
            export ARCH='aarch64'; \
        ;; \
    esac \
    && \
    HOME_ASSISTANT_BASE=$(curl -fsSL "https://raw.githubusercontent.com/home-assistant/core/${VERSION}/build.yaml" | grep "${ARCH}: " | cut -d ":" -f3) \
    && \
    uv pip install --system --only-binary=:all: --find-links "${HOMEASSISTANT_WHEELS}" \
        --requirement "https://raw.githubusercontent.com/home-assistant/docker/${HOME_ASSISTANT_BASE}/requirements.txt" \
    && \
    uv pip install --system --only-binary=:all: --find-links "${HOMEASSISTANT_WHEELS}" \
        --requirement /tmp/requirements_all.txt \
    && \
    uv pip install --system --only-binary=:all: --find-links "${HOMEASSISTANT_WHEELS}" \
        homeassistant=="${VERSION}" \
    && \
    mkdir -p /config \
    && chown nobody:nogroup -R /config \
    && \
    apk del --purge .build-deps \
    && \
    rm -rf \
        /root/.cache \
        /root/.cargo \
        /tmp/*

COPY entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/home-assistant/core"