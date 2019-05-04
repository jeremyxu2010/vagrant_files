#!/bin/bash

sed -i -e 's/^broker.id=.*$/broker.id=1/' /etc/kafka/server.properties
sed -i -e 's/^zookeeper.connect=.*$/zookeeper.connect=192.168.2.131:2181,192.168.2.132:2181,192.168.2.133:2181/' /etc/kafka/server.properties

cat << EOF >> /etc/kafka/server.properties
host.name=192.168.2.131
port=9092
EOF

systemctl restart kafka
systemctl enable kafka