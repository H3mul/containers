# The calibre installer requires glibc, so keep the builder on Ubuntu. The
# final image uses Alpine with gcompat for a smaller runtime image.
FROM ubuntu:24.04 AS builder

ARG VERSION

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates \
    git \
    libegl1 \
    libfreetype6 \
    libopengl0 \
    libxcb-cursor0 \
    python3 \
    xz-utils && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "${VERSION}" https://github.com/kovidgoyal/calibre.git /usr/src/calibre

RUN python3 /usr/src/calibre/setup/linux-installer.py \
    install_dir=/opt \
    isolated=true \
    version="${VERSION#v}"

WORKDIR /opt/calibre
RUN rm -rf  lib/qt_plugins lib/libQt* resources/localization resources/images

FROM alpine:3.24.1 AS runner

RUN apk add --no-cache \
    bash \
    ca-certificates \
    findutils \
    gcompat \
    libstdc++ \
    mesa-gl \
    xdg-utils

COPY --from=builder /opt/calibre /opt/calibre

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod a+x /usr/bin/docker-entrypoint.sh

ENV PATH=/opt/calibre/bin:$PATH
ENV CALIBRE_LIBRARY_DIRECTORY=/opt/calibredb/library
ENV CALIBRE_CONFIG_DIRECTORY=/opt/calibredb/config
ENV CALIBREDB_AUTOIMPORT_DIRECTORY=/opt/calibredb/import

VOLUME /opt/calibredb/config
VOLUME /opt/calibredb/import
VOLUME /opt/calibredb/library

CMD ["/usr/bin/docker-entrypoint.sh"]
