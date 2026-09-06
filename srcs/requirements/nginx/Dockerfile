FROM debian:bookworm
RUN apt-get update && apt-get install -y nginx openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/inception.key -out /etc/ssl/certs/inception.crt -subj "/C=MA/ST=Marrakesh/L=Ben Guerir/O=1337/CN=himousta.42.fr"
COPY conf/nginx.conf /etc/nginx/conf.d/
CMD ["nginx", "-g", "daemon off;"]