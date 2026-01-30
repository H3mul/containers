FROM alpine:3.23.3@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache bash ansible=${VERSION} git openssh rsync

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
