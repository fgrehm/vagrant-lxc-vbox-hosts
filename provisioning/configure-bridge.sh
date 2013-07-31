#!/bin/bash

LXC_BRIDGE="lxcbr0"
if $(brctl show | grep ${LXC_BRIDGE} -q); then
  echo "The bridge '${LXC_BRIDGE}' already exists!"
  exit 0
fi

LXC_BASE_ADDR="10.0.53"
LXC_ADDR="${LXC_BASE_ADDR}.1"
LXC_NETMASK="255.255.255.0"
LXC_NETWORK="${LXC_BASE_ADDR}.0/24"
LXC_DHCP_RANGE="${LXC_BASE_ADDR}.2,${LXC_BASE_ADDR}.254"
LXC_DHCP_MAX="253"
varrun="/var/run/lxc"

if [ -f /etc/dnsmasq.conf ]; then
  sed 's/^#\(bind-interfaces\)/\1/g' -i.bak /etc/dnsmasq.conf
  service dnsmasq restart
fi

cleanup() {
  # dnsmasq failed to start, clean up the bridge
  sudo iptables -t nat -D POSTROUTING -s ${LXC_NETWORK} ! -d ${LXC_NETWORK} -j MASQUERADE || true
  sudo ifconfig ${LXC_BRIDGE} down || true
  sudo brctl delbr ${LXC_BRIDGE} || true
}

echo 1 > /proc/sys/net/ipv4/ip_forward

mkdir -p ${varrun}

brctl addbr ${LXC_BRIDGE}

ifconfig ${LXC_BRIDGE} ${LXC_ADDR} netmask ${LXC_NETMASK} up

iptables -t nat -A POSTROUTING -s ${LXC_NETWORK} ! -d ${LXC_NETWORK} -j MASQUERADE

dnsmasq --strict-order \
        --bind-interfaces \
        --pid-file=${varrun}/dnsmasq.pid \
        --conf-file= \
        --listen-address ${LXC_ADDR} \
        --dhcp-range ${LXC_DHCP_RANGE} \
        --dhcp-lease-max=${LXC_DHCP_MAX} \
        --dhcp-no-override \
        --except-interface=lo \
        --interface=${LXC_BRIDGE} \
        --dhcp-leasefile=/var/lib/misc/dnsmasq.${LXC_BRIDGE}.leases \
        --dhcp-authoritative \
        || cleanup

touch ${varrun}/network_up
