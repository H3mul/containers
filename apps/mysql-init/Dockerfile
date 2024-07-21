FROM alpine:3.20

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache ca-certificates mysql-client bash

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
