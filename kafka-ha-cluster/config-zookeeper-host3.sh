#!/bin/bash

cat << EOF >> /etc/zookeeper/zoo.cfg
server.1=192.168.2.131:2888:3888
server.2=192.168.2.132:2888:3888
server.3=192.168.2.133:2888:3888
EOF

echo "3" > /var/lib/zookeeper/myid

systemctl restart zookeeper
systemctl enable zookeeper