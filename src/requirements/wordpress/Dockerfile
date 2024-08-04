FROM debian:oldstable

ARG WP_DATABASE
ARG WP_USER
ARG WP_PASSWORD

WORKDIR /var/www/html/

RUN apt update && apt upgrade -y && \
	apt install -y php7.4 php-fpm php-mysql \
	mariadb-client wordpress wget