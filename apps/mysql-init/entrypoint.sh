#!/usr/bin/env bash

# This is most commonly set to the user 'root'
export INIT_MYSQL_SUPER_USER=${INIT_MYSQL_SUPER_USER:-root}

if [[ -z "${INIT_MYSQL_HOST}"       ||
      -z "${INIT_MYSQL_SUPER_PASS}" ||
      -z "${INIT_MYSQL_USER}"       ||
      -z "${INIT_MYSQL_PASS}"       ||
      -z "${INIT_MYSQL_DBNAME}"
]]; then
    printf "\e[1;32m%-6s\e[m\n" "Invalid configuration - missing a required environment variable"
    [[ -z "${INIT_MYSQL_HOST}" ]]       && printf "\e[1;32m%-6s\e[m\n" "INIT_MYSQL_HOST: unset"
    [[ -z "${INIT_MYSQL_SUPER_PASS}" ]] && printf "\e[1;32m%-6s\e[m\n" "INIT_MYSQL_SUPER_PASS: unset"
    [[ -z "${INIT_MYSQL_USER}" ]]       && printf "\e[1;32m%-6s\e[m\n" "INIT_MYSQL_USER: unset"
    [[ -z "${INIT_MYSQL_PASS}" ]]       && printf "\e[1;32m%-6s\e[m\n" "INIT_MYSQL_PASS: unset"
    [[ -z "${INIT_MYSQL_DBNAME}" ]]     && printf "\e[1;32m%-6s\e[m\n" "INIT_MYSQL_DBNAME: unset"
    exit 1
fi

# These env are for the psql CLI
export MYSQL_HOST="${INIT_MYSQL_HOST}"
export USER="${INIT_MYSQL_SUPER_USER}"
export MYSQL_PWD="${INIT_MYSQL_SUPER_PASS}"

user_exists=$(\
    user_exists=$(mysql -e "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '${INIT_MYSQL_USER}');")
)

if [[ -z "${user_exists}" ]]; then
    printf "\e[1;32m%-6s\e[m\n" "Create User ${INIT_MYSQL_USER} ..."
    mysql -e "CREATE USER IF NOT EXISTS '${INIT_MYSQL_USER}'@'localhost' IDENTIFIED BY '${INIT_MYSQL_PASS}';"
else
    printf "\e[1;32m%-6s\e[m\n" "Update password for user ${INIT_MYSQL_USER} ..."
    mysql -e "ALTER USER '${INIT_MYSQL_USER}'@'localhost' IDENTIFIED BY '${INIT_MYSQL_PASS}';"
fi

for dbname in ${INIT_MYSQL_DBNAME}; do
    printf "\e[1;32m%-6s\e[m\n" "Create Database ${dbname} ..."
    mysql -e "CREATE DATABASE IF NOT EXISTS ${dbname};"

    printf "\e[1;32m%-6s\e[m\n" "Update User Privileges on Database ..."
    mysql -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${INIT_MYSQL_USER}'@'localhost';"
done