#!/bin/bash

set -e

if $(which lxc-create > /dev/null); then
  echo 'dependencies already installed'
else
  apt-get update  -q
  # TODO: Check if we'll need to always upgrade the kernel
  export DEBIAN_FRONTEND=noninteractive
  # NFS SERVER!
  apt-get install -y -q lxc redir btrfs-tools # linux-image-generic linux-headers-generic btrfs-tools
  apt-get autoremove -y
fi

if [[ `uname -r` == "3.5.0-17-generic" ]]; then
  echo 'An old kernel was found on the guest machine and was upgraded'
  echo 'Please restart the machine'
fi
