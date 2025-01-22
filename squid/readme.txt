"How to install the Squid HTTP Proxy version 6.x on Ubuntu 22.04"

# cd /tmp
# apt update && apt upgrade -y
# wget https://www.squid-cache.org/Versions/v6/squid-6.12.tar.gz
# tar xzf squid-6.12.tar.gz
# cd squid-6.12
# apt -y install \
libcppunit-dev \
libsasl2-dev \
libxml2-dev \
libkrb5-dev \
libdb-dev \
libnetfilter-conntrack-dev \
libexpat1-dev \
libcap-dev \
libldap2-dev \
libpam0g-dev \
libgnutls28-dev \
libssl-dev \
libdbi-perl \
libecap3 \
libecap3-dev \
libsystemd-dev \
net-tools \
ccze
# apt -y install build-essential
# ./configure --prefix=/usr \
--localstatedir=/var \
--libexecdir=${prefix}/lib/squid \
--datadir=${prefix}/share/squid \
--sysconfdir=/etc/squid \
--with-default-user=proxy \
--with-logdir=/var/log/squid \
--with-pidfile=/var/run/squid.pid \
--with-default-user=proxy \
--with-openssl \
--enable-ssl-crtd \
--enable-icap-client \
--enable-ltdl-convenience \
--enable-cache-digests
# make
# make install
# squid -v
# cd /var/log
# chown -R proxy:proxy squid
# cd /var/cache
# chown -Rf proxy:proxy squid
# cd /etc/squid
# openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout squidCA.pem -out squidCA.pem
# openssl x509 -in squidCA.pem -outform DER -out squid.der
# chown proxy:proxy squidCA.pem
# chmod 400 squidCA.pem
# mkdir -p /var/lib/squid
# /usr/lib/squid/security_file_certgen -c -s /var/lib/squid/ssl_db -M 4MB
# chown -R proxy:proxy /var/lib/squid
# nano /etc/squid/squid.conf
# echo 'tail -f /var/log/squid/cache.log | ccze -A -C -o noscroll' > /usr/sbin/ca
# echo 'tail -f /var/log/squid/access.log | ccze -A -C -o noscroll' > /usr/sbin/ac
# chmod +x /usr/sbin/ca
# chmod +x /usr/sbin/ac
# nano /etc/rc.local
# chmod +x /etc/rc.local
# systemctl start rc-local
# nano /usr/lib/systemd/system/squid.service
# nano /etc/init.d/squid
# chmod +x /etc/init.d/squid
# systemctl enable --now squid
# systemctl start squid
# netstat -tulnp | grep squid
# ac