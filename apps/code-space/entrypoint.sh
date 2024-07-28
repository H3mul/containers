#! /bin/bash

set -eu

if [ -z "$( ls -A "/home/${USERNAME}" )" ]; then
  cp -a /etc/skel/* "/home/${USERNAME}"
fi
  
chown "${USERNAME}":"${USERNAME}" -R "/home/${USERNAME}"

/usr/bin/supervisord