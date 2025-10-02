#! /bin/bash

set -eu

if [ -d /workspace ]; then
    if [ ! -d /workspace/models ]; then
        mv ./models /workspace/models
    fi
    rm -rf ./models
    ln -s /workspace/models ./models
fi

supervisord -c /etc/supervisord.conf