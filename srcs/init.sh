service nginx start
service mysql start
service php7.3-fpm start

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | myql -u root --skip-password
echo "UPDATE mysql.user set plugin='' WHERE user='root';" | mysql -u root --skip-password

bash