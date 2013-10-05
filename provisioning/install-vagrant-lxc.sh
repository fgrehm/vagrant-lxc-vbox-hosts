#!/bin/bash

if $(grep -q 'VAGRANT_DEFAULT_PROVIDER=lxc' /home/vagrant/.bashrc); then
  echo 'vagrant-lxc already configured'
  exit 0
fi

echo 'export VAGRANT_DEFAULT_PROVIDER=lxc' >> /home/vagrant/.bashrc

VAGRANT_HOME=/home/vagrant/.vagrant.d su -p vagrant -c '
  if ! $(vagrant plugin list | grep -q lxc); then
    vagrant plugin install vagrant-lxc
  fi
'
