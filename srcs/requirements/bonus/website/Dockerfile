FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx

# Delete the default Debian NGINX config
RUN rm -f /etc/nginx/sites-enabled/default

RUN mkdir -p /var/www/website

COPY conf/site.conf /etc/nginx/conf.d/default.conf

# Copy HTML portfolio into the web folder
COPY app /var/www/website/

# permissions to read the files
RUN chown -R www-data:www-data /var/www/website

# Run NGINX in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]