# FROM jrottenberg/ffmpeg:7.1-alpine
FROM linuxserver/ffmpeg:version-8.0-cli@sha256:053970615c3b200898e34ece30d4064a071f74aefc694d7782ffcccd761d2a65


ENV PERIOD_DAYS=7 \
    INPUT_DIR="" \
    OUTPUT_DIR="" \
    FPS=30 \
    DATETIME_REGEX='.*_\([0-9]\{8\}\)-[0-9]\{6\}\.jpg$'

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]