# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Comment out if you don't have plans to use https://github.com/fgrehm/vagrant-cachier
  config.cache.auto_detect = true

  config.vm.provider :virtualbox do |vb|
    vb.customize [ "modifyvm", :id, "--memory", 512, "--cpus", "1" ]
  end

  config.vm.define :quantal64 do |quantal|
    quantal.vm.box     = 'quantal64'
    quantal.vm.box_url = 'https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box'
  end

  config.vm.define :squeeze64 do |squeeze|
    squeeze.vm.box     = 'squeeze64'
    squeeze.vm.box_url = 'http://dl.dropbox.com/u/174733/debian-squeeze-64.box'
  end

  config.vm.provision :shell, path: 'provisioning/install-dependencies.sh'
  # Choose any Vagrant version from 1.2.0 to 1.2.7
  config.vm.provision :shell, path: 'provisioning/install-vagrant.rb', args: "'1.2.7'"
  config.vm.provision :shell, path: 'provisioning/install-vagrant-lxc.sh'
  config.vm.provision :shell, path: 'provisioning/configure-bridge.sh'
  config.vm.provision :shell, path: 'provisioning/configure-cgroups.sh'
end
