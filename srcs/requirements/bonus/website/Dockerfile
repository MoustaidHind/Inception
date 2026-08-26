FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx

# ADD THIS LINE: Delete the default Debian NGINX config
RUN rm -f /etc/nginx/sites-enabled/default

RUN mkdir -p /var/www/website

COPY conf/site.conf /etc/nginx/conf.d/default.conf

# Copy your HTML portfolio into the web folder
COPY app /var/www/website/

# Grant NGINX permissions to read the files
RUN chown -R www-data:www-data /var/www/website

# Run NGINX in the foreground (Docker's PID 1 rule!)
CMD ["nginx", "-g", "daemon off;"]