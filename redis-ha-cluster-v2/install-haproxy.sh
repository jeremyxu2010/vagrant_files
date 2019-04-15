#!/bin/bash

yum install -y haproxy

cat << EOF >> /etc/haproxy/haproxy.cfg

frontend predixy
    mode tcp
    option tcplog
    bind *:17617
    default_backend predixy_servers


backend predixy_servers
    balance roundrobin
    server redis-host1 192.168.2.111:7617 check inter 1500 rise 3 fall 3 weight 2
    server redis-host2 192.168.2.112:7617 check inter 1500 rise 3 fall 3 weight 2
    server redis-host3 192.168.2.113:7617 check inter 1500 rise 3 fall 3 weight 2
EOF

systemctl start haproxy
systemctl enable haproxy