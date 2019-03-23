#!/bin/bash

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint nodes --all node-role.kubernetes.io/master-

sudo docker pull registry.cn-qingdao.aliyuncs.com/wangdali/flannel:v0.11.0-amd64
sudo docker tag registry.cn-qingdao.aliyuncs.com/wangdali/flannel:v0.11.0-amd64 quay.io/coreos/flannel:v0.11.0-amd64

kubectl apply -f files/kube-flannel.yml

echo 'source <(kubectl completion bash)' >> ~/.bashrc