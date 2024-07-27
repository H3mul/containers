#! /bin/bash

set -eu

if id "${USERNAME}" ; then
    echo "User already exists: ${USERNAME}"
else
    echo "Creating new sudo user ${USERNAME}"
    useradd -G sudo -s /bin/bash -m "${USERNAME}"
    passwd -d "${USERNAME}"
fi

chown "${USERNAME}":"${USERNAME}" -R "/home/${USERNAME}"

/usr/bin/supervisord