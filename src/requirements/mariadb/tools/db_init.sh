#!/bin/bash

#------------------ mariadb start ------------------#
service mariadb start

#------------------ mariadb config -----------------#
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${WP_DATABASE};"
mariadb -u root -e "CREATE USER '${WP_USER}'@'%' IDENTIFIED BY '${WP_PASSWORD}';"
mariadb -u root -e "GRANT ALL ON ${WP_DATABASE}.* TO '${WP_USER}'@'%' \
                    IDENTIFIED BY '${WP_PASSWORD}';"
mariadb -u root -e "FLUSH PRIVILEGES;"
