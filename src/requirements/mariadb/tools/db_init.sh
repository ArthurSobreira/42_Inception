#!/bin/bash

service mariadb start

mariadb -u root -e \
    "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; \
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
    GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
    FLUSH PRIVILEGES;"

service mariadb stop