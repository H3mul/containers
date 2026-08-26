FROM debian:bookworm-slim@sha256:88200866dfff7ea7f5cbcb6ec7c8a701889efe6fe859fe64d6990e4b07ea4171 AS downloader

ARG OPEN_STAGE_CONTROL_VERSION=1.30.3
ARG OPEN_STAGE_CONTROL_BASE_URL=https://openstagecontrol.ammd.net/packages

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN curl -fsSLo open-stage-control.zip \
        "${OPEN_STAGE_CONTROL_BASE_URL}/open-stage-control_${OPEN_STAGE_CONTROL_VERSION}_node.zip" \
    && unzip -q open-stage-control.zip -d extracted \
    && mv extracted/open-stage-control_${OPEN_STAGE_CONTROL_VERSION}_node /open-stage-control

FROM node:24-bookworm-slim@sha256:a9f5f7c91a432850b2a8a7797adf5eadb6c733ceed61167806cee7ea7fbc29df

LABEL org.opencontainers.image.title="Open Stage Control"
LABEL org.opencontainers.image.description="Container image for the Open Stage Control node-only release"
LABEL org.opencontainers.image.source="https://framagit.org/jean-emmanuel/open-stage-control"

ENV OSC_PORT=8080
ENV OSC_OSC_PORT=8080
ENV OSC_CACHE_DIR=/cache
ENV OSC_REMOTE_ROOT=/data
ENV OSC_SEND=""

WORKDIR /opt

COPY --from=downloader /open-stage-control /opt/open-stage-control
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && mkdir -p /config /data

VOLUME ["/config", "/data"]

EXPOSE 8080/tcp
EXPOSE 8080/udp

ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
