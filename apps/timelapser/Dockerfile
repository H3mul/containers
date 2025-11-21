# FROM jrottenberg/ffmpeg:7.1-alpine
FROM linuxserver/ffmpeg:version-8.0-cli@sha256:2d1569b07dd249fd8a4eeff0afb3c7e4a2e83e6b37d97bf28837f6ccd57b23d8


ENV PERIOD_DAYS=7 \
    INPUT_DIR="" \
    OUTPUT_DIR="" \
    FPS=30 \
    DATETIME_REGEX='.*_\([0-9]\{8\}\)-[0-9]\{6\}\.jpg$'

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]