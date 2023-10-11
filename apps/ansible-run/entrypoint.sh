#!/usr/bin/env bash

if [ -f "${REQUIREMENTS_FILE}" ]; then
    ansible-galaxy install -r ${REQUIREMENTS_FILE}
fi

if [ -f "${PLAYBOOK_FILE}" ]; then
    ansible-playbook ${PLAYBOOK_FILE} \
    -i ${INVENTORY} \
    -e ansible_ssh_common_args='"-o StrictHostKeyChecking=no"' \
    ${ADDITIONAL_ARGS}
else
    echo "No playbook file found: ${PLAYBOOK_FILE}" >2
fi
