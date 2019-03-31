#!/bin/bash
yum install -y sshuttle

sleep 5
sshuttle -r root@192.168.33.10 10.96.0.0/12 > sshuttle_svc_cidr.log 2>&1 &
sleep 5
sshuttle -r root@192.168.33.10 10.244.0.0/16 > sshuttle_pod_cidr.log 2>&1 &

# test
# kubectl get svc --all-namespaces
# telnet ${some_svc_ip} ${some_svc_port}
# kubectl get endpoints --all-namespaces
# telnet ${some_pod_ip} ${some_pod_port}