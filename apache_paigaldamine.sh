# apache paigaldusskript

apache_olemas=$(dpkg-query -W -f='${status}' apache2 2>/dev/null | grep -c 'ok installed')
if [ $apache_olemas -eq 0 ]; then
	echo "Algab apache2 paigaldus..."
	apt install apache2
	echo "Apache2 on paigaldatud"
elif [ $apache_olemas -eq 1 ]; then
	echo "Apache2 on juba paigaldatud!"
	service apache2 start
	service apache2 status
fi

# skripti lõpp
