#!/bin/bash

sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/busybox:1.30.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/busybox:1.30.1 busybox:1.30.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/citadel:1.1.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/citadel:1.1.1 docker.io/istio/citadel:1.1.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/galley:1.1.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/galley:1.1.1 docker.io/istio/galley:1.1.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/kubectl:1.1.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/kubectl:1.1.1 docker.io/istio/kubectl:1.1.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/mixer:1.1.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/mixer:1.1.1 docker.io/istio/mixer:1.1.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/pilot:1.1.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/pilot:1.1.1 docker.io/istio/pilot:1.1.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/proxy_init:1.1.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/proxy_init:1.1.1 docker.io/istio/proxy_init:1.1.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/proxyv2:1.1.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/proxyv2:1.1.1 docker.io/istio/proxyv2:1.1.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/sidecar_injector:1.1.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/sidecar_injector:1.1.1 docker.io/istio/sidecar_injector:1.1.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/all-in-one:1.9
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/all-in-one:1.9 docker.io/jaegertracing/all-in-one:1.9
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/kiali:v0.14
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/kiali:v0.14 docker.io/kiali/kiali:v0.14
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/prometheus:v2.3.1
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/prometheus:v2.3.1 docker.io/prom/prometheus:v2.3.1
sudo docker pull registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/grafana:5.4.0
sudo docker tag registry.cn-hangzhou.aliyuncs.com/jeremyxu2010/grafana:5.4.0 grafana/grafana:5.4.0

wget 'https://github.com/istio/istio/releases/download/1.1.1/istio-1.1.1-linux.tar.gz'
tar -xf istio-1.1.1-linux.tar.gz
cd istio-1.1.1
sed -e 's/LoadBalancer/NodePort/' install/kubernetes/istio-demo.yaml > install/kubernetes/istio-demo-nodeport.yaml

until kubectl cluster-info > /dev/null 2>&1;
do
    sleep 1
done

for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done
kubectl apply -f install/kubernetes/istio-demo-nodeport.yaml