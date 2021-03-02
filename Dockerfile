FROM debian:buster

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

WORKDIR /var/www/html

# Install phpMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin

# Install Wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz

RUN openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=France/L=Paris/OU=42paris/CN=localhost" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

# Copy nginf conf file to sites-available
COPY ./srcs/default /etc/nginx/sites-available/

# Copy phpMyAdmin conf file
COPY ./srcs/config.inc.php phpmyadmin

# Copy wordpress conf file
COPY ./srcs/wp-config.php /var/www/html

RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*
COPY ./srcs/init.sh ./

EXPOSE 80 443

CMD bash init.sh