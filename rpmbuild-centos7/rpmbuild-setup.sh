#!/bin/bash

sudo yum install -y gcc make rpm-build redhat-rpm-config

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros
