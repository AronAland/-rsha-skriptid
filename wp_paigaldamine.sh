# WordPressi paigaldusskript

# apache

apache_olemas=$(dpkg-query -W -f='${status}' apache2 2>/dev/null | grep -c 'ok installed')
if [ $apache_olemas -eq 0 ]; then
	echo "Algab apache2 paigaldus..."
	apt install apache2
	echo "Apache2 on paigaldatud"
	service apache2 start
elif [ $apache_olemas -eq 1 ]; then
	echo "Apache2 on juba paigaldatud!"
	service apache2 start
fi

# apache lõpp

# php

php_olemas=$(dpkg-query -W -f='${status}' php7.0 2>/dev/null | grep -c 'ok installed')

if [ $php_olemas -eq 0 ]; then
	echo "PHP ja vajalikude lisade paigaldamine..."
	apt install php7.0 libapache2-mod-php7.0 php7.0-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip
	echo "PHP paigaldatud";
	service apache2 restart
elif [ $php_olemas -eq 1 ]; then
	echo "PHP on juba paigaldatud!"
fi

# php lõpp

# mysql

mysql_olemas=$(dpkg-query -W -f='${status}' mysql-server 2>/dev/null | grep -c 'ok installed')
if [ $mysql_olemas -eq 0 ]; then
	echo "Paigaldame mysql ja vajalikud lisad"
	apt install mysql-server
	echo "MySQL on paigaldatud!"
	touch $HOME/.my.cnf
	echo "[client]"  >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
        mysql <<EOF
        	CREATE DATABASE wordpress;
        	CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'qwerty';
        	GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
        	FLUSH PRIVILEGES;
EOF
elif [ $mysql_olemas -eq 1 ]; then
	echo "MySQL on juba paigaldatud!"
	mysql <<-EOF
		CREATE DATABASE wordpress;
		CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'qwerty';
		GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
		FLUSH PRIVILEGES;
EOF
fi

# mysql lõpp

# wordpress

cd /tmp
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
touch wordpress/.htaccess
cp wordpress/wp-config-sample.php wordpress/wp-config.php
mkdir /tmp/wordpress/wp-content/upgrade
sed -i 's/database_name_here/wordpress/g' wordpress/wp-config.php
sed -i 's/username_here/wordpressuser/g' wordpress/wp-config.php
sed -i 's/password_here/qwerty/g' wordpress/wp-config.php
cp -a /tmp/wordpress/. /var/www/wordpress
rm -rf /etc/apache2/sites-enabled/wordpress.conf
rm -rf /etc/apache2/sites-enabled/000-default.conf
touch /etc/apache2/sites-enabled/wordpress.conf
echo "<VirtualHost *:80>" >> /etc/apache2/sites-enabled/wordpress.conf
echo "ServerName wordpress" >> /etc/apache2/sites-enabled/wordpress.conf
echo "DocumentRoot /var/www/wordpress" >> /etc/apache2/sites-enabled/wordpress.conf
echo "<Directory /var/www/wordpress/>" >> /etc/apache2/sites-enabled/wordpress.conf
echo "AllowOverride All" >> /etc/apache2/sites-enabled/wordpress.conf
echo "</Directory>" >> /etc/apache2/sites-enabled/wordpress.conf
echo "</VirtualHost>" >> /etc/apache2/sites-enabled/wordpress.conf
a2enmod rewrite
apache2ctl configtest
systemctl restart apache2
chown -R www-data:www-data /var/www/wordpress
find /var/www/wordpress/ -type d -exec chmod 750 {} \;
find /var/www/wordpress/ -type f -exec chmod 640 {} \;
echo "Wordpress on paigaldatud!"
# wordpress lõpp
