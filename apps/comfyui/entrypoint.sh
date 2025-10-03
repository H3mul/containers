#! /bin/bash

set -eu

if [ -d "${DATA_PATH}" ]; then
   [ -d "${DATA_PATH}/models" ] || mkdir -p "${DATA_PATH}/models"
   rm -r /opt/comfyui/models && ln -s "${DATA_PATH}/models" /opt/comfyui/models
fi

if [[ $PUBLIC_KEY ]]; then
    echo "Setting up SSH..."
    mkdir -p ~/.ssh
    echo -e "${PUBLIC_KEY}\n" >> ~/.ssh/authorized_keys
    chmod 700 -R ~/.ssh

    if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
        ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -q -N ''
    fi

    if [ ! -f /etc/ssh/ssh_host_dsa_key ]; then
        ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -q -N ''
    fi

    if [ ! -f /etc/ssh/ssh_host_ecdsa_key ]; then
        ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -q -N ''
    fi

    if [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
        ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -q -N ''
    fi

    echo "SSH host keys:"
    cat /etc/ssh/*.pub
fi

supervisord -c /etc/supervisord.conf