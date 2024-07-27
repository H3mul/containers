#! /bin/bash

set -eu

if id "${USERNAME}" ; then
    echo "User already exists: ${USERNAME}"
else
    echo "Creating new sudo user ${USERNAME}"
    useradd -G sudo -s ${USER_SHELL} -m "${USERNAME}"
    passwd -d "${USERNAME}"
fi

chown "${USERNAME}":"${USERNAME}" -R "/home/${USERNAME}"

if [ ! -z ${CHEZMOI_GH_USER} ]; then
    sudo -u "${USERNAME}" chezmoi init ${CHEZMOI_GH_USER} --force
    sudo -u "${USERNAME}" chezmoi state reset
    sudo -u "${USERNAME}" chezmoi update
fi

if [ -z ${VS_SERVER_USER} ]; then
    export VS_SERVER_USER=${USERNAME}
fi

/usr/bin/supervisord