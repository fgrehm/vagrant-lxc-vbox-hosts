#!/bin/bash

set -e

if $(/sbin/ifconfig | grep -q lxcbr0); then
  echo 'Bridge already configured'
  exit 0
fi

# Configure bridge
export DEBIAN_FRONTEND=noninteractive
apt-get install -y -q bridge-utils dnsmasq

cat <<-STR > /etc/dnsmasq.d/lxc
bind-interfaces
except-interface=lxcbr0
STR

/etc/init.d/dnsmasq restart

cp /vagrant/templates/lxc-net /etc/init.d/lxc-net

echo 'USE_LXC_BRIDGE="true"' >> /etc/default/lxc

chmod +x /etc/init.d/lxc-net
update-rc.d lxc-net start
/etc/init.d/lxc-net start

# TODO: Move this to a separate script
echo 'none  /sys/fs/cgroup  cgroup  defaults  0  0' >> /etc/fstab
mount /sys/fs/cgroup
