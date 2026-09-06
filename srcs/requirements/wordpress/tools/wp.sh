#!/bin/bash

# 1. Create the folder where NGINX will look for the website
mkdir -p /var/www/wordpress
cd /var/www/wordpress

# 2. Download the core WordPress files
# (We use --allow-root because Docker runs as the root administrator, and WP-CLI normally complains(blocks) about this)
wp-cli core download --allow-root

# Give MariaDB 10 seconds to fully wake up before we try to connect!
sleep 10

# 3. Create the wp-config.php file to connect to the Vault
wp-cli config create --dbname=${SQL_DATABASE} \
                 --dbuser=${SQL_USER} \
                 --dbpass=${SQL_PASSWORD} \
                 --dbhost=mariadb \
                 --allow-root

# --- ADD REDIS CONFIGURATION HERE ---
# These commands safely inject the constants into the newly created wp-config.php
wp-cli config set WP_REDIS_HOST redis --allow-root
wp-cli config set WP_REDIS_PORT 6379 --raw --allow-root
# ------------------------------------

# 4. Install WordPress and set up the Admin account
#--url=himousta.42.fr \
wp-cli core install --url=https://localhost \
                --title="Inception" \
                --admin_user=${WP_ADMIN_USER} \
                --admin_password=${WP_ADMIN_PASSWORD} \
                --admin_email=${WP_ADMIN_EMAIL} \
                --allow-root

# 5. Create a standard, non-admin user (This is a strict requirement for the project!)
wp-cli user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author --allow-root

wp-cli theme install twentytwentyfour --activate --path=/var/www/wordpress --allow-root
#wp-cli theme activate twentysixteen

# 6. PHP-FPM needs this specific folder to exist so it can manage its processes
mkdir -p /run/php

# 6. Enable Redis Cache
wp-cli plugin install redis-cache --activate --allow-root
wp-cli redis enable --allow-root

# 7. Turn on the Kitchen in the foreground so the container stays alive
exec /usr/sbin/php-fpm8.2 -F