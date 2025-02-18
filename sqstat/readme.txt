"How to install & setup SqStat-1.20"

*) Install PHP (7.4) using Ondrej PPA (https://tecadmin.net/how-to-install-php-on-ubuntu-22-04/)
# apt update && apt upgrade -y
# apt autoremove -y
# apt install -y software-properties-common ca-certificates lsb-release apt-transport-https
# LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php
# apt upgrade -y
# apt install php7.4 -y
# php -v

*) Install SqStat-1.20
# cd /var/www/html
# wget https://samm.kiev.ua/sqstat/sqstat-1.20.tar.gz
# tar zxvf sqstat-1.20.tar.gz
# mv sqstat-1.20 sqstat
# cd sqstat
# mv config.inc.php.defaults config.inc.php
# patch sqstat.class.php sqstat_squid32.patch
# nano /etc/squid/squid.conf

# ---------------------------------------------------- #
# SqStat-1.20
acl webserver src 10.5.50.2/32
http_access allow manager localhost
http_access allow manager webserver
http_access deny manager
# ---------------------------------------------------- #
# Regular ACL Rules Settings

# systemctl restart squid

*) Open http://10.5.50.2/sqstat/sqstat.php in browser