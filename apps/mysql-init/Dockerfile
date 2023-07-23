FROM alpine:3.18

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache ca-certificates mysql-client bash

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
