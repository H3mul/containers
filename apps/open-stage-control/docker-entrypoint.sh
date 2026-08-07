#!/bin/sh
set -eu

set -- \
  node /opt/open-stage-control \
  --no-gui \
  --cache-dir "${OSC_CACHE_DIR:-/cache}" \
  --remote-root "${OSC_REMOTE_ROOT:-/data}" \
  --port "${OSC_PORT:-8080}" \
  --osc-port "${OSC_OSC_PORT:-${OSC_PORT:-8080}}"

if [ -n "${OSC_TCP_PORT:-}" ]; then
  set -- "$@" --tcp-port "${OSC_TCP_PORT}"
fi

if [ -n "${OSC_LOAD:-}" ]; then
  set -- "$@" --load "${OSC_LOAD}"
fi

if [ -n "${OSC_STATE:-}" ]; then
  set -- "$@" --state "${OSC_STATE}"
fi

if [ -n "${OSC_CUSTOM_MODULE:-}" ]; then
  set -- "$@" --custom-module "${OSC_CUSTOM_MODULE}"
fi

if [ -n "${OSC_THEME:-}" ]; then
  set -- "$@" --theme "${OSC_THEME}"
fi

if [ -n "${OSC_CLIENT_OPTIONS:-}" ]; then
  set -- "$@" --client-options "${OSC_CLIENT_OPTIONS}"
fi

if [ -n "${OSC_AUTHENTICATION:-}" ]; then
  set -- "$@" --authentication "${OSC_AUTHENTICATION}"
fi

if [ -n "${OSC_SEND:-}" ]; then
  set -- "$@" --send "${OSC_SEND}"
fi

if [ "${OSC_READ_ONLY:-false}" = "true" ]; then
  set -- "$@" --read-only
fi

if [ "${OSC_USE_SSL:-false}" = "true" ]; then
  set -- "$@" --use-ssl
fi

if [ "${OSC_DEBUG:-false}" = "true" ]; then
  set -- "$@" --debug
fi

if [ "${OSC_NO_QRCODE:-false}" = "true" ]; then
  set -- "$@" --no-qrcode
fi

exec "$@"
