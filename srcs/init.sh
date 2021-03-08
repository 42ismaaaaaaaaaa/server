service mysql start

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "UPDATE mysql.user set plugin='' WHERE user='root';" | mysql -u root --skip-password

if [[ $AUTOINDEX == "off" ]]
then
    sed -i -r 's/.autoindex./autoindex off;/g' /etc/nginx/sites-available/default
else
    sed -i -r 's/.autoindex./autoindex on;/g' /etc/nginx/sites-available/default
fi

service nginx start
service php7.3-fpm start

bash