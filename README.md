# Rakendusserverite halduse automatiseerimine
bash skriptimine

## APACHE2
Apache2 paigaldusskript kontrollib kas masinal on juba apache2 paigaldatud ning kui ei ole, siis paigaldab selle.

## Paigaldusskripti käivitamine
````
chmod +x apache_paigaldamine.sh
sh apache_paigaldamine.sh
````
## PHP
PHP paigaldusskript kontrollib kas masinal on juba PHP paigaldatud ning kui ei ole, siis paigaldab selle koos vajalikkude lisapakettidega.

## Paigaldusskripti käivitamine
````
chmod +x php_paigaldamine.sh
sh php_paigaldamine.sh
````
## MySQL Server
MySQL-i paigaldusskript kontrollib kas masinal on juba MySQL server paigaldatud ning kui ei ole, siis paigaldab selle.

## Paigaldusskripti käivitamine
````
chmod +x mysql_paigaldamine.sh
sh mysql_paigaldamine.sh
````
## Wordpressi paigaldamine ja seadistamine
Wordpressi paigaldusskript kontrollib kas masinal on juba kõik vajalikud teenused paigaldatud, et Wordpressi paigaldada. Vajalikkude teenuste puudumisel paigaldab need ning seejärel paigaldab Wordpressi, et hiljem ainult läbi brauseri seadistus lõpetada.

## Paigaldusskripti käivitamine
````
chmod +x wp_paigaldamine.sh
sh wp_paigaldamine.sh
````

## Wordpressi seadistamine brauseris
![Image of Wordpress](https://imgur.com/YwYQIf6)
