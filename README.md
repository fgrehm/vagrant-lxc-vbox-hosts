# vagrant-lxc ready VirtualBox machines

Basically a set of Vagrant VirtualBox machines ready for [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)
usage, serving as "live documentation" on how to set up hosts for using the plugin.

## Usage

```
$ git clone https://github.com/fgrehm/vagrant-lxc-vbox-hosts.git
$ cd vagrant-lxc-vbox-hosts
$ vagrant up BOX_NAME --provider=virtualbox
$ vagrant reload BOX_NAME
```

## Available boxes

| BOX_NAME | Distro |
| -------- | ------ |
| quantal64 | Ubuntu 12.10 64 bits |
| squeeze64 | Debian 6.0 64 bits |
