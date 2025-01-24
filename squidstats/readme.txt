"How to install & setup squidstats-r54"

# cd /tmp
# apt -y install snmp snmpd apache2 librrds-perl 
# wget https://www.dropbox.com/s/23yb1ul3g21cu8o/squidstats-r54.tar
# tar -xf squidstats-r54.tar
# cd squidstats-r54
# cp mib.txt /etc/squid/
# cp /tmp/snmpd.conf /etc/snmp/
# nano Makefile.defaults
  line 9. WEB_DATADIR ?=  /var/www/html
# nano graph/src/graph-summary.cgi.in
  line 93. remove "/"
# make && make install
# snmpwalk -v 1 -c public localhost
# perl -MCPAN -e shell
  yes
  cpan[1]> install SNMP_Session
  cpan[1]> install Config::IniFiles
  cpan[1]> install CGI
  cpan[1]> q
# squidstats.pl createdb
# squidstats.pl gather
# cp /tmp/squidstats.conf /etc/apache2/sites-available
# a2ensite squidstats.conf
# sudo a2enmod cgi
# systemctl restart apache2
# crontab -e
  */5 * * * * /usr/local/bin/squidstats.pl gather >/dev/null
# nano /etc/squid/squid.conf 
then paste this:

# ---------------------------------------------------- #
# Specific ACL Rules Settings
acl no_cache_graphs url_regex ^http://10\.5\.50\.2/graphs/
acl no_cache_squid_ip dst 10.5.50.2
cache deny no_cache_graphs
cache deny no_cache_squid_ip
always_direct allow no_cache_graphs
always_direct allow no_cache_squid_ip
# ---------------------------------------------------- #
# Do-Not-Track Settings

# squid -k reconfigure

in the browser open the site
http://10.5.50.2/squidstats/graph-summary.cgi
