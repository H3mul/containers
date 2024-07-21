FROM alpine:3.20

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache bash ansible git openssh rsync

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
