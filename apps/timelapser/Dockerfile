# FROM jrottenberg/ffmpeg:7.1-alpine
FROM linuxserver/ffmpeg:version-8.0-cli@sha256:c0d0182939986c52bd2ab96e2686890d537970e8da5f4c04745f372ef0e1e70a


ENV PERIOD_DAYS=7 \
    INPUT_DIR="" \
    OUTPUT_DIR="" \
    FPS=30 \
    DATETIME_REGEX='.*_\([0-9]\{8\}\)-[0-9]\{6\}\.jpg$'

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]