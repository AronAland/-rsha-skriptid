# PHP paigaldusskript

php_olemas=$(dpkg-query -W -f='${status}' php7.0 2>/dev/null | grep -c 'ok installed')

if [ $php_olemas -eq 0 ]; then
	echo "PHP ja vajalikude lisade paigaldamine..."
	apt install php7.0 libapache2-mod-php7.0 php7.0-mysql
	echo "PHP paigaldatud";
elif [ $php_olemas -eq 1 ]; then
	echo "PHP on juba paigaldatud!"
	which php
fi

# skripti lõpp

