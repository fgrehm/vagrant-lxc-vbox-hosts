#!/bin/bash

set -e

if $(/sbin/ip addr show lxcbr0); then
        echo "Bridge already configured"
        exit 0
fi

# Install needed packages
yum install -y bridge-utils dnsmasq

# Add dnsmasq configuration
cat <<-STR > /etc/dnsmasq.d/lxc
bind-interfaces
except-interface=lxcbr0
STR

systemctl restart dnsmasq.service

cat <<-EOF > /etc/systemd/system/lxc-net.service
[Unit]
Description=Network service for LXC Containers

[Service]
Type=oneshot

# Bring up bridge interface and start dnsmasq
ExecStart=/sbin/brctl addbr lxcbr0
ExecStart=/sbin/ip address add 192.168.150.1/24 dev lxcbr0
ExecStart=/sbin/ip link set lxcbr0 up
ExecStart=/usr/sbin/dnsmasq \
            --dhcp-leasefile=/var/run/lxc-dnsmasq.leases \
            --user=nobody \
            --group=nobody \
            --listen-address=192.168.150.1 \
            --except-interface=lo \
            --bind-interfaces \
            --dhcp-range=192.168.150.2,192.168.150.254 \
            --dhcp-option=option:dns-server,8.8.8.8,8.8.4.4

# Configure firewalld
ExecStart=/usr/bin/firewall-cmd --zone=trusted --add-interface=lxcbr0
ExecStart=/usr/bin/firewall-cmd --zone=public --add-masquerade
ExecStart=/usr/bin/firewall-cmd --direct --add-rule ipv4 mangle POSTROUTING 0 -o lxcbr0 -p udp --dport bootpc -j CHECKSUM --checksum-fill

RemainAfterExit=yes

# Bring bridge interface down
ExecStop=/sbin/ip link set lxcbr0 down
ExecStop=/sbin/brctl delbr lxcbr0

# Remove firewall rules
ExecStop=/usr/bin/firewall-cmd --zone=trusted --remove-interface=lxcbr0
ExecStop=/usr/bin/firewall-cmd --zone=public --remove-masquerade
ExecStop=/usr/bin/firewall-cmd --direct --remove-rule ipv4 mangle POSTROUTING 0 -o lxcbr0 -p udp --dport bootpc -j CHECKSUM --checksum-fill

[Install]
WantedBy=default.target
EOF

systemctl enable lxc-net.service
systemctl start lxc-net.service

