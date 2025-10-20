# FROM jrottenberg/ffmpeg:7.1-alpine
FROM linuxserver/ffmpeg:version-8.0-cli@sha256:784db915924daf9081ab57b46b91d37610c60da5d9600ffd9855c7568fadc697


ENV PERIOD_DAYS=7 \
    INPUT_DIR="" \
    OUTPUT_DIR="" \
    FPS=30 \
    DATETIME_REGEX='.*_\([0-9]\{8\}\)-[0-9]\{6\}\.jpg$'

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]