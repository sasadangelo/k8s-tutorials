mkdir -p /var/log/nginx
chown -R www-data:www-data /var/log/nginx
chmod 755 /var/log/nginx
service php7.0-fpm start && /usr/sbin/nginx
