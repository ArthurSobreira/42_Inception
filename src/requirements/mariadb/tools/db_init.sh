#!/bin/bash

#------------------ mariadb start ------------------#
service mariadb start

# Just because I'm don't make the docker-compose file yet
WP_DATABASE=wordpress_database
WP_USER=arsobrei
WP_PASSWORD=anicepassword@

#------------------ mariadb config -----------------#
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${WP_DATABASE};"
mariadb -u root -e "CREATE USER '${WP_USER}'@'%' IDENTIFIED BY '${WP_PASSWORD}';"
mariadb -u root -e "GRANT ALL ON ${WP_DATABASE}.* TO '${WP_USER}'@'%' \
                    IDENTIFIED BY '${WP_PASSWORD}';"
mariadb -u root -e "FLUSH PRIVILEGES;"
