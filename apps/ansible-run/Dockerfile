FROM alpine:3.24.4@sha256:93b41ef40b1677fce8fcc64ff4af09daddfacf5040afde618bc46c1e2d1cc7d4

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache bash ansible=${VERSION} git openssh rsync

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
