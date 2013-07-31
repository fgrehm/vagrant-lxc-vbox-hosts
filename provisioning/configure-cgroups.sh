#!/bin/bash

if $(mount | grep 'cgroup' -q); then
  echo 'cgroup already mounted'
  exit 0
fi

if ! $(grep 'cgroup' /etc/fstab -q); then
  echo 'cgroup  /sys/fs/cgroup  cgroup  defaults  0   0' >> /etc/fstab
fi

mount /sys/fs/cgroup
echo 'cgroup mounted!'
