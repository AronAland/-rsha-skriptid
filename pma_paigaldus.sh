# PMA paigaldusskript
pma_olemas=$(dpkg-query -W -f='${status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')
if [ $pma_olemas -eq 0 ]; then
	echo "PhpMyAdmini paigaldamine koos vajalikkude lisadega..."
	apt install phpmyadmin
	echo "PhpMyAdmin paigaldatud!"
elif [ $pma_olemas -eq 1 ]; then
	echo "PhpMyAdmin on juba paigaldatud"
fi

#skripti lõpp
