# MySQL paigaldusskript

mysql_olemas=${dpkg-query -W -f='${status}' mysql-server 2>/dev/null | grep -c 'ok installed')

if [ $mysql_olemas -eq 0 ]; then
	echo "Paigaldame mysql ja vajalikud lisad"
	apt install mysql-server
	echo "MySQL on paigaldatud!"
	touch $HOME/.my.cnf
	echo "[client]"  >> $HOME/.my.cnf
	echo "host = lcoalhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
elif [ $mysql_olemas -eq 1 ]; then
	echo "MySQL on juba paigaldatud!"
	mysql
fi

#skripti lõpp
