# FROM jrottenberg/ffmpeg:7.1-alpine
FROM linuxserver/ffmpeg:version-8.0-cli


ENV PERIOD_DAYS=7 \
    INPUT_DIR="" \
    OUTPUT_DIR=""

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]