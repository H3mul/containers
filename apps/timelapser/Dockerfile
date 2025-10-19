FROM jrottenberg/ffmpeg:7.1-alpine

ENV PERIOD_DAYS=7 \
    INPUT_DIR="" \
    OUTPUT_DIR=""

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]