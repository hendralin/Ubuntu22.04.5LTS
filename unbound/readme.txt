"How to install the Unbound DNS resolver on Ubuntu 22.04"

# apt install unbound -y
# cd /etc/unbound
# wget ftp://ftp.internic.net/domain/named.cache
# nano /etc/unbound/unbound.conf.d/myunbound.conf
# unbound-checkconf
# touch /var/log/unbound.log
# chown unbound:unbound /var/log/unbound.log
# systemctl status unbound
# systemctl enable --now unbound
# ss -lnptu | grep 53
# apt install resolvconf
# systemctl disable systemd-resolved --now
# cat /etc/resolv.conf
# systemctl restart unbound
# nslookup google.com
# dig google.com @localhost
# unbound-control stats