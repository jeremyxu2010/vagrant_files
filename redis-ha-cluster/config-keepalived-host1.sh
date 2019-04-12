#!/bin/bash

cp -f /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.bak
cat << EOF > /etc/keepalived/keepalived.conf
global_defs {
    router_id LVS_HAPROXY
}
vrrp_script chk_haproxy {
    script "killall -0 haproxy"
    interval 2
    weight 2
}
vrrp_instance VI_HAPROXY {
    state MASTER
    interface eth1
    virtual_router_id 88
    priority 110
    advert_int 1
    virtual_ipaddress {
        192.168.2.114
    }
    track_script {
        chk_haproxy
    }
}
EOF

systemctl enable keepalived
systemctl start keepalived

