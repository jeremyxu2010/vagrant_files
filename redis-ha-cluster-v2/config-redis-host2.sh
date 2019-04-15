#!/bin/bash

cp -f /etc/redis.conf /etc/redis_6379.conf
sed -i -e 's/^bind.*$/bind 192.168.2.112/' /etc/redis_6379.conf
sed -i -e 's/^protected-mode.*$/protected-mode no/' /etc/redis_6379.conf
sed -i -e 's/^port.*$/port 6379/' /etc/redis_6379.conf
sed -i -e 's#^pidfile.*$#pidfile /var/run/redis_6379.pid#' /etc/redis_6379.conf
sed -i -e 's#^logfile.*$#logfile /var/log/redis_6379/redis.log#' /etc/redis_6379.conf
sed -i -e 's#^dir.*$#dir /var/lib/redis_6379#' /etc/redis_6379.conf
sed -i -e 's#^appendonly.*$#appendonly yes#' /etc/redis_6379.conf
cat << EOF >> /etc/redis_6379.conf
cluster-enabled yes
cluster-config-file nodes-6379.conf
cluster-node-timeout 5000
EOF
chown redis:root /etc/redis_6379.conf
mkdir /var/lib/redis_6379
mkdir /var/log/redis_6379
chown redis:redis /var/lib/redis_6379
chown redis:redis /var/log/redis_6379
chmod 750 /var/lib/redis_6379
chmod 750 /var/log/redis_6379
cp -r /etc/systemd/system/redis.service.d /etc/systemd/system/redis_6379.service.d
cat << EOF > /usr/lib/systemd/system/redis_6379.service
[Unit]
Description=Redis persistent key-value database (6379)
After=network.target

[Service]
ExecStart=/usr/bin/redis-server /etc/redis_6379.conf --supervised systemd
ExecStop=/usr/libexec/redis-shutdown redis_6379
Type=notify
User=redis
Group=redis
RuntimeDirectory=redis
RuntimeDirectoryMode=0755

[Install]
WantedBy=multi-user.target
EOF
systemctl enable redis_6379
systemctl start redis_6379
cat << EOF >> /etc/logrotate.d/redis
/var/log/redis_6379/*.log {
    weekly
    rotate 10
    copytruncate
    delaycompress
    compress
    notifempty
    missingok
}
EOF

cp -f /etc/redis.conf /etc/redis_6380.conf
sed -i -e 's/^bind.*$/bind 192.168.2.112/' /etc/redis_6380.conf
sed -i -e 's/^protected-mode.*$/protected-mode no/' /etc/redis_6380.conf
sed -i -e 's/^port.*$/port 6380/' /etc/redis_6380.conf
sed -i -e 's#^pidfile.*$#pidfile /var/run/redis_6380.pid#' /etc/redis_6380.conf
sed -i -e 's#^logfile.*$#logfile /var/log/redis_6380/redis.log#' /etc/redis_6380.conf
sed -i -e 's#^dir.*$#dir /var/lib/redis_6380#' /etc/redis_6380.conf
sed -i -e 's#^appendonly.*$#appendonly yes#' /etc/redis_6380.conf
cat << EOF >> /etc/redis_6380.conf
cluster-enabled yes
cluster-config-file nodes-6380.conf
cluster-node-timeout 5000
EOF
chown redis:root /etc/redis_6380.conf
mkdir /var/lib/redis_6380
mkdir /var/log/redis_6380
chown redis:redis /var/lib/redis_6380
chown redis:redis /var/log/redis_6380
chmod 750 /var/lib/redis_6380
chmod 750 /var/log/redis_6380
cp -r /etc/systemd/system/redis.service.d /etc/systemd/system/redis_6380.service.d
cat << EOF > /usr/lib/systemd/system/redis_6380.service
[Unit]
Description=Redis persistent key-value database (6380)
After=network.target

[Service]
ExecStart=/usr/bin/redis-server /etc/redis_6380.conf --supervised systemd
ExecStop=/usr/libexec/redis-shutdown redis_6380
Type=notify
User=redis
Group=redis
RuntimeDirectory=redis
RuntimeDirectoryMode=0755

[Install]
WantedBy=multi-user.target
EOF
systemctl enable redis_6380
systemctl start redis_6380
cat << EOF >> /etc/logrotate.d/redis
/var/log/redis_6380/*.log {
    weekly
    rotate 10
    copytruncate
    delaycompress
    compress
    notifempty
    missingok
}
EOF
