#!/bin/bash

yum install -y nginx
systemctl restart nginx

iptables -t nat -A PREROUTING -p tcp --dport 81 -j REDIRECT --to-port 80
iptables -t nat -A OUTPUT -p tcp --dport 81 -j REDIRECT --to-port 80

# test with curl
curl -v http://192.168.33.12:81