FROM debian:oldstable

ARG WP_DATABASE
ARG WP_USER
ARG WP_PASSWORD
ARG WP_EMAIL

WORKDIR /var/www/html/

RUN apt update && apt upgrade -y && \
	apt install -y php7.4 php-fpm php-mysql \
	mariadb-client wordpress wget

RUN wget -O /usr/local/bin/wp \
	https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x /usr/local/bin/wp && \
	wp core download --allow-root --path=/var/www/html

RUN mkdir /run/php

RUN chmod 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/script.sh /tmp/wp_setup.sh

RUN chmod +x /tmp/wp_setup.sh

ENTRYPOINT [ "/tmp/wp_setup.sh" ]