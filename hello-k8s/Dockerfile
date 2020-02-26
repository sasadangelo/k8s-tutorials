# Our docker image start from Ubuntu 16.04 Xenial image
FROM ubuntu:16.04

# Install nginx
RUN apt-get update; apt-get install -y nginx php7.0 php7.0-gd php7.0-mysql php7.0-curl vim

# Configure nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the PHP code in /home/www/www-data
COPY ./www-data /home/www/www-data

# Copy the version file in the Docker image
COPY VERSION .
COPY VERSION /home/www/www-data

# Create the /var/log/nginx and assign the right ownership and permissions
RUN mkdir -p /var/log/nginx && \
	chown -R www-data:www-data /var/log/nginx && \
	chmod -R 755 /var/log/nginx

# Expose port 80
EXPOSE 80
# Run nginx
CMD service php7.0-fpm start && /usr/sbin/nginx
