#!/bin/bash

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
        http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum clean all

swapoff -a
sed -i -e '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo 'net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1' > /etc/sysctl.d/k8s.conf
sysctl --system

yum install -y docker
systemctl start docker
systemctl enable docker
docker info

yum install -y kubelet kubeadm kubectl

systemctl start kubelet.service
systemctl enable kubelet.service

docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.13.4
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.13.4 k8s.gcr.io/kube-apiserver:v1.13.4
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.13.4
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.13.4 k8s.gcr.io/kube-controller-manager:v1.13.4
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.13.4
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.13.4 k8s.gcr.io/kube-scheduler:v1.13.4
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.13.4
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.13.4 k8s.gcr.io/kube-proxy:v1.13.4
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.1
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.1 k8s.gcr.io/pause:3.1
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.2.24
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.2.6
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6

yum install -y net-tools
IPADDR=$(ifconfig eth1|grep inet|grep -v inet6|awk '{print $2}')
hostname
kubeadm init --apiserver-advertise-address $IPADDR --apiserver-cert-extra-sans $IPADDR --service-cidr 10.96.0.0/12 --pod-network-cidr 10.244.0.0/16 --kubernetes-version v1.13.4



