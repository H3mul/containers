#! /bin/bash

set -eu

chown "${USERNAME}":"${USERNAME}" -R "/home/${USERNAME}"

/usr/bin/supervisord