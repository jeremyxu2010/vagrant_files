#!/bin/bash

yum install -y http://dl.marmotte.net/rpms/redhat/el7/x86_64/zookeeper-3.4.13-1.el7/zookeeper-3.4.13-1.el7.noarch.rpm

mkdir /var/lib/zookeeperLog && chown zookeeper:zookeeper /var/lib/zookeeperLog && chmod 700 /var/lib/zookeeperLog

cat << EOF >> /etc/zookeeper/zoo.cfg
autopurge.snapRetainCount=3
autopurge.purgeInterval=1
dataLogDir=/var/lib/zookeeperLog
EOF
