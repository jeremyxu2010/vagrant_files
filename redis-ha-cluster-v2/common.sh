#!/bin/bash
set -e -x -u

curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum -y install epel-release
curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum install -y net-tools vim git htop tmux tcpdump lsof telnet wget

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i -e 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# disable firewalld
systemctl stop firewalld
systemctl disable firewalld
