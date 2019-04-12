#!/bin/bash

sed -i -e 's/^bind.*$/bind 192.168.2.113/' /etc/redis.conf
sed -i -e 's/^protected-mode.*$/protected-mode no/' /etc/redis.conf
sed -i -e '${s/$/\nslaveof 192.168.2.111 6379/}' /etc/redis.conf

systemctl enable redis
systemctl start redis

sed -i -e '${s/$/\nbind 192.168.2.113\nprotected-mode no/}' /etc/redis-sentinel.conf
sed -i -e '/^sentinel/ s/mymaster/clusterinstance/g' /etc/redis-sentinel.conf
sed -i -e 's/^sentinel monitor clusterinstance.*$/sentinel monitor clusterinstance 192.168.2.111 6379 2/' /etc/redis-sentinel.conf

systemctl enable redis-sentinel
systemctl start redis-sentinel