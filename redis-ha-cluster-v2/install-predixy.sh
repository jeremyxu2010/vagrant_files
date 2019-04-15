#!/bin/bash

tar -xf /home/vagrant/files/predixy-1.0.5-bin-amd64-linux.tar.gz -C /opt/

sed -i -e 's/^Name.*$/Name PredixyProxy/' /opt/predixy-1.0.5/conf/predixy.conf
sed -i -e 's/^WorkerThreads.*$/WorkerThreads 4/' /opt/predixy-1.0.5/conf/predixy.conf
sed -i -e '/^Include try.conf/ s/^/#/' /opt/predixy-1.0.5/conf/predixy.conf
sed -i -e '/^# Include cluster.conf/ s/^# //' /opt/predixy-1.0.5/conf/predixy.conf
sed -i -e '/^[^#].*$/ s/^/#/g' /opt/predixy-1.0.5/conf/auth.conf
cat << EOF >> /opt/predixy-1.0.5/conf/auth.conf
Authority {
    Auth {
        Mode admin
    }
}
EOF
cat << EOF >> /opt/predixy-1.0.5/conf/cluster.conf
ClusterServerPool {
    MasterReadPriority 40
    StaticSlaveReadPriority 50
    DynamicSlaveReadPriority 60
    RefreshInterval 1
    ServerTimeout 1
    ServerFailureLimit 10
    ServerRetryTimeout 1
    KeepAlive 120
    Servers {
        + 192.168.2.111:6379
        + 192.168.2.112:6379
        + 192.168.2.113:6379
    }
}
EOF
cat << EOF >> /usr/lib/systemd/system/predixy.service
[Unit]
Description=Redis predixy proxy service
After=network.target

[Service]
User=root
Group=root
PermissionsStartOnly=true
ExecStart=/opt/predixy-1.0.5/bin/predixy /opt/predixy-1.0.5/conf/predixy.conf
Restart=always
LimitNOFILE=10240

[Install]
WantedBy=multi-user.target
EOF

#systemctl start predixy
#systemctl enable predixy