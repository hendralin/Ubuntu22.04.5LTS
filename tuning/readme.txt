"Server & Kernel Tuning"

# apt update && apt upgrade -y

# echo "loop
ipv6
ip_gre
ip_conntrack" >> /etc/modules

# reboot 

# echo "524288" > /proc/sys/net/netfilter/nf_conntrack_max
# echo "0" > /proc/sys/net/ipv4/conf/gre0/rp_filter
# mv /etc/sysctl.conf /etc/sysctl.conf_
# touch /etc/sysctl.conf

# echo "#kernel.domainname = example.com
#kernel.printk = 3 4 1 3
net.ipv4.tcp_syncookies=1
net.ipv4.tcp_timestamps=1
net.ipv4.tcp_window_scaling=1
net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1
net.netfilter.nf_conntrack_max=262144
#net.ipv4.conf.all.accept_redirects = 0
#net.ipv6.conf.all.accept_redirects = 0
#net.ipv4.conf.all.secure_redirects = 1
net.ipv4.conf.all.send_redirects=1
net.ipv6.conf.all.accept_source_route=1
#net.ipv4.conf.all.log_martians = 1

# Local Port Range
net.ipv4.ip_local_port_range=1024 65535

# Nginx FD Limit
fs.file-max=262144
vm.swappiness=50

# Squid non Tproxy
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1

# Squid Tproxy
#net.ipv4.conf.default.rp_filter=0
#net.ipv4.conf.all.rp_filter=0
#net.ipv4.conf.eth0.rp_filter=0
#net.ipv4.conf.lo.rp_filter=0
#net.ipv4.conf.gre0.rp_filter=0

# Setup DNS threshold for arp
net.ipv4.neigh.default.gc_thresh1=512
net.ipv4.neigh.default.gc_thresh2=2048
net.ipv4.neigh.default.gc_thresh3=4096

# VM Dirty
vm.dirty_background_ratio=5
vm.dirty_ratio=10

# Kernel
kernel.hung_task_timeout_secs=0
" > /etc/sysctl.conf

# ulimit -n 262144
# ulimit -HSd unlimited
# sysctl -p
# echo 262144 > /proc/sys/fs/file-max

# echo "*         soft        nofile          262144
*         hard        nofile          262144
root      soft        nofile          262144
root      hard        nofile          262144
proxy     soft        nofile          262144
proxy     hard        nofile          262144" >> /etc/security/limits.conf

# reboot
