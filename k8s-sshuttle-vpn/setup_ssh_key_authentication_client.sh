#!/bin/bash

mkdir /root/.ssh
cp /home/vagrant/files/id_rsa /root/.ssh/id_rsa
cat << EOF > /root/.ssh/config
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
EOF
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 600 /root/.ssh/config
