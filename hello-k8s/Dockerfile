# Our docker image start from Ubuntu 16.04 Xenial image
FROM ubuntu:16.04

# Install nginx
RUN apt-get update; apt-get install -y nginx php7.0 php7.0-gd php7.0-mysql php7.0-curl vim

# Configure nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the PHP code in /home/www/www-data
COPY ./www-data /home/www/www-data

# Copy the version file in the Docker image
COPY entrypoint.sh .
COPY VERSION .
COPY VERSION /home/www/www-data

# Expose port 80
EXPOSE 80
# Run nginx
ENTRYPOINT /entrypoint.sh
