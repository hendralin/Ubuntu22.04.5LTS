# nov/15/2024 16:26:48 by RouterOS 6.49.17
#
/queue simple
add max-limit=30M/30M name=ProxyCache packet-marks=proxy-packs queue=\
    default-small/pcq-download-default target="" total-queue=default

/ip address
add address=10.5.50.1/30 interface=ether2-proxy network=10.5.50.0
add address=172.18.197.1/24 interface=ether3-local network=172.18.197.0

/ip firewall mangle
add action=accept chain=prerouting comment="No proxy User" dst-address-list=\
    no-cache
add action=add-dst-to-address-list address-list=ToPROXY address-list-timeout=\
    20s chain=prerouting comment="Mikrotik WCCP Checker" dst-port=2048 \
    protocol=udp src-address=10.5.50.2
add action=mark-routing chain=prerouting comment=\
    "Proxy - Mangle ====================>" dst-port=80 in-interface=\
    ether3-local new-routing-mark=proxy_route passthrough=no protocol=tcp
add action=mark-routing chain=prerouting dst-port=443 in-interface=\
    ether3-local new-routing-mark=proxy_route passthrough=no protocol=tcp \
    src-address-list=https_users
add action=mark-routing chain=prerouting dst-port=443 in-interface=\
    ether3-local new-routing-mark=proxy_route passthrough=no protocol=udp \
    src-address-list=https_users
add action=mark-connection chain=forward comment=\
    "Proxy - HIT ====================>" dscp=12 new-connection-mark=\
    proxy-connection passthrough=yes
add action=mark-packet chain=forward connection-mark=proxy-connection \
    new-packet-mark=proxy-packs passthrough=no

/ip firewall nat
add action=accept chain=dstnat comment="Do not go through the Cache" \
    dst-address-list=no-cache protocol=tcp
add action=masquerade chain=srcnat comment=Masquerade out-interface=\
    ether1-public

/ip route
add comment=proxy distance=1 gateway=10.5.50.2 routing-mark=proxy_route

/system scheduler
add interval=10s name="MONITORING PROXY" on-event=":global PROXY\r\
    \n:if ([/ip firewall address-list find list=ToPROXY] = \"\") do={\r\
    \n:if (\$PROXY != \"down\") do={\r\
    \n/ip route disable [find comment=\"proxy\"]\r\
    \n:set PROXY \"down\"\r\
    \n:log error \"ProxyCache [ DOWN ]\"\r\
    \n}\r\
    \n} else={\r\
    \n:if (\$PROXY != \"hidup\") do={\r\
    \n/ip route enable [find comment=\"proxy\"]\r\
    \n:set PROXY \"hidup\"\r\
    \n:log warning \"ProxyCache [ UP ]\"\r\
    \n}\r\
    \n}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive \
    start-time=startup