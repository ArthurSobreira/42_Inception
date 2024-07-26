FROM debian:oldstable

RUN apt update && apt upgrade -y && \
	apt install -y nginx openssl

RUN openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=BR/ST=SP/L=Sao Paulo/O=42SP/OU=Student/CN=arsobrei.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d/

# Remove this line later
COPY index.html /usr/share/nginx/html/index.html

# This too
EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]