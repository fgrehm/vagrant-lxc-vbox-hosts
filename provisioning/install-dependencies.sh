#!/bin/bash

if $(which lxc-create > /dev/null); then
  echo 'Dependencies already installed'
  exit 0
fi

set -e

apt-get update  -q
apt-get upgrade -y
apt-get install -y -q \
                lxc \
                redir \
                htop \
                btrfs-tools \
                vim \
                dnsmasq \
                bash-completion \
                bridge-utils \
                curl

if $(grep -q 'Ubuntu' /etc/issue); then
  apt-get install -y linux-image-generic linux-headers-generic apparmor-utils
fi
