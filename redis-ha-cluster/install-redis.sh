#!/bin/bash

yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum -y --enablerepo=remi install redis

