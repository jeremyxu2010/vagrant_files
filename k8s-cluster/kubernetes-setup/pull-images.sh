#!/bin/bash

MIRROR_IMAGES=(\
    registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.13.4 \
    registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.13.4 \
    registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.13.4 \
    registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.13.4 \
    registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.1 \
    registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.2.24 \
    registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.2.6 \
    registry.cn-qingdao.aliyuncs.com/wangdali/flannel:v0.11.0-amd64
    )

TARGET_IMAGES=(\
    k8s.gcr.io/kube-apiserver:v1.13.4 \
    k8s.gcr.io/kube-controller-manager:v1.13.4 \
    k8s.gcr.io/kube-scheduler:v1.13.4 \
    k8s.gcr.io/kube-proxy:v1.13.4 \
    k8s.gcr.io/pause:3.1 \
    k8s.gcr.io/etcd:3.2.24 \
    k8s.gcr.io/coredns:1.2.6 \
    quay.io/coreos/flannel:v0.11.0-amd64
    )


for ((i=0; i<${#MIRROR_IMAGES[@]}; i++)) do
   docker pull ${MIRROR_IMAGES[i]}
    while [[ $? -ne 0 ]] ; do 
        docker pull ${MIRROR_IMAGES[i]}
    done
    docker tag ${MIRROR_IMAGES[i]} ${TARGET_IMAGES[i]}
done
