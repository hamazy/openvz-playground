#!/usr/bin/env bash

set -o errexit
set -o nounset

[ ! -f /etc/yum.repos.d/openvz.repo ] && wget -q -P /etc/yum.repos.d/ http://ftp.openvz.org/openvz.repo
rpm --import http://ftp.openvz.org/RPM-GPG-Key-OpenVZ

yum install -y vzkernel
yum install -y vzctl vzquota ploop
[ ! -f /vz/template/cache/centos-6-x86_64.tar.gz ] && wget -q -P /vz/template/cache/ http://download.openvz.org/template/precreated/centos-6-x86_64.tar.gz
