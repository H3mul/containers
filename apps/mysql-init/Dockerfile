FROM alpine:3.21@sha256:b97e2a89d0b9e4011bb88c02ddf01c544b8c781acf1f4d559e7c8f12f1047ac3

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache ca-certificates mysql-client=${VERSION} bash

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
