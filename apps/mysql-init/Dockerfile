FROM alpine:3.20@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache ca-certificates mysql-client=${VERSION} bash

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
