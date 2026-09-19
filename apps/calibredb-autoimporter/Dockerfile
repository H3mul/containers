FROM debian:bookworm-slim@sha256:3783cc01769c7b2b1b83a5c5ad96c815348e28ed7da68e2e3687004faa906251

ARG VERSION

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    bash \
    ca-certificates \
    findutils \
    libegl1 \
    libfreetype6 \
    libgl1 \
    libopengl0 \
    libxcb-cursor0 \
    libxcomposite1 \
    xvfb \
    git \
    python3 \
    xz-utils \
    && git clone --depth 1 --branch "${VERSION}" \
       https://github.com/kovidgoyal/calibre.git /usr/src/calibre \
    && python3 /usr/src/calibre/setup/linux-installer.py \
       install_dir=/opt \
       version="${VERSION#v}" \
    && rm -rf /usr/src/calibre /root/.cache \
    && apt-get purge -y --auto-remove git python3 xz-utils \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod a+x /usr/bin/docker-entrypoint.sh

ENV PATH=/opt/calibre/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/calibre/lib

ENV CALIBRE_LIBRARY_DIRECTORY=/opt/calibredb/library
ENV CALIBREDB_AUTOIMPORT_DIRECTORY=/opt/calibredb/import
ENV CALIBREDB_IMPORT_TIMEOUT=15
ENV CALIBREDB_IMPORT_TAG="autoimport"


VOLUME /opt/calibredb/config
VOLUME /opt/calibredb/import
VOLUME /opt/calibredb/library

CMD ["/usr/bin/docker-entrypoint.sh"]
