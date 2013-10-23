# -*- mode: ruby -*-
# vi: set ft=ruby :

# Avoid the need to pass in --provider=virtualbox all the time in case the
# variable is set
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", id: 'vagrant-root', nfs: true
  # Comment out if you don't have plans to use https://github.com/fgrehm/vagrant-cachier
  config.cache.auto_detect = true
  config.cache.enable_nfs  = true

  config.vm.provider :virtualbox do |vb|
    vb.customize [ "modifyvm", :id, "--memory", 1536, "--cpus", "1" ]
  end

  # Choose any Vagrant version from 1.2.0 to 1.3.3
  config.vm.provision :shell, path: 'provisioning/install-vagrant.rb', args: "'1.3.3'"
  config.vm.provision :shell, path: 'provisioning/install-vagrant-lxc.sh'

  config.vm.define :precise do |ubuntu|
    ubuntu.vm.box     = 'precise64'
    ubuntu.vm.box_url = 'http://files.vagrantup.com/precise64.box'
    ubuntu.vm.network :private_network, ip: "192.168.50.100"
    ubuntu.vm.provision :shell, path: 'provisioning/debian/install-dependencies.sh'
  end

  config.vm.define :quantal do |ubuntu|
    ubuntu.vm.box     = 'quantal64'
    ubuntu.vm.box_url = 'https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box'
    ubuntu.vm.network :private_network, ip: "192.168.50.101"
    ubuntu.vm.provision :shell, path: 'provisioning/debian/install-dependencies.sh'
  end

  config.vm.define :raring do |ubuntu|
    ubuntu.vm.box = 'raring64'
    ubuntu.vm.box_url = 'http://goo.gl/Y4aRr'
    ubuntu.vm.network :private_network, ip: "192.168.50.102"
    ubuntu.vm.provision :shell, path: 'provisioning/debian/install-dependencies.sh'
  end

  config.vm.define :saucy do |ubuntu|
    ubuntu.vm.box = 'saucy64'
    ubuntu.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box'
    ubuntu.vm.network :private_network, ip: "192.168.50.103"
    ubuntu.vm.provision :shell, path: 'provisioning/debian/install-dependencies.sh'
  end

  config.vm.define :wheezy do |debian|
    debian.vm.box = 'wheezy64'
    debian.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box'
    debian.vm.network :private_network, ip: "192.168.50.105"
    debian.vm.provision :shell, path: 'provisioning/debian/install-dependencies.sh'
    debian.vm.provision :shell, path: 'provisioning/debian/configure-bridge.sh'
  end
end
