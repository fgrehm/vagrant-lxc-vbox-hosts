#!/bin/bash

set -e

if $(which lxc-create > /dev/null); then
  echo 'dependencies already installed'
  exit 0
else
  yum update -y
  yum install -y redir tar python3

  mkdir -p /tmp/lxc
  pushd /tmp/lxc
    curl -L -O http://thm.fedorapeople.org/lxc/fedora-19/x86_64/lua-lxc-0.9.0-1.fc19.x86_64.rpm
    curl -L -O http://thm.fedorapeople.org/lxc/fedora-19/x86_64/lxc-0.9.0-1.fc19.x86_64.rpm
    curl -L -O http://thm.fedorapeople.org/lxc/fedora-19/x86_64/lxc-libs-0.9.0-1.fc19.x86_64.rpm
    # curl -L -O http://thm.fedorapeople.org/lxc/fedora-19/x86_64/lxc-templates-0.9.0-1.fc19.x86_64.rpm
    curl -L -O http://thm.fedorapeople.org/lxc/fedora-19/x86_64/python3-lxc-0.9.0-1.fc19.x86_64.rpm
    rpm -Uvh *.rpm
  popd
fi
