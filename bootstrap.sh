#!/usr/bin/env bash

set -o errexit
set -o nounset

yum update -y
yum install -y man ed avahi

cat >>/home/vagrant/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRBdTxEPqF4NTBocTcVipsrXqVXPpM8ZfUxK2/SlYh2hLefPAnfz4eFw72dRUG8JnXpvQu1de9DCKL9s51XbZZ0B1Clbvn8Rx9f4zhK+SReFRk4E1jLPnZKwrfK0/wb723QidLDYpNAtE7wWKY/JyMcfhteLLf+MpmbM/LJgPsrPsSOIIw3xOqWhOLQWe6wPHgGLKLisR+yGMSDi6l3EzpdKRxRQJMot3u0rY4yLlf5YEIgXPWwZVlAHVV7hFlQCZwsBcs2EPKZ/bEodvAdzGKsiBWvuJOGpbOKewYkuW3ws5CKXIXj6eRrTjM2Uey9ab/o2LLHpiDrwytPrk/ho69 hamazy@Suguru-Hamazakis-MacBook-Air-2.local
EOF

ed /etc/sysconfig/network <<EOF
/^HOSTNAME/
c
HOSTNAME=openvz01.local
.
w
q
EOF

ed /etc/hosts <<EOF
/^127
c
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 openvz01.local
.
/::1
c
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6 openvz01.local
.
w
q
EOF

hostname openvz01.local
service network restart
