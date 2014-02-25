#!/usr/bin/env ruby

VAGRANTS = {
  '1.4.3' => 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.3_x86_64',
  '1.4.2' => 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.2_x86_64',
  '1.4.1' => 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.1_x86_64',
  '1.4.0' => 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.0_x86_64',
  '1.3.5' => 'http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64',
  '1.3.4' => 'http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/vagrant_1.3.4_x86_64',
  '1.3.3' => 'http://files.vagrantup.com/packages/db8e7a9c79b23264da129f55cf8569167fc22415/vagrant_1.3.3_x86_64',
  '1.3.2' => 'http://files.vagrantup.com/packages/9a394588a6dcf97e8f916da9564088fcf242c4b3/vagrant_1.3.2_x86_64',
  '1.3.1' => 'http://files.vagrantup.com/packages/b12c7e8814171c1295ef82416ffe51e8a168a244/vagrant_1.3.1_x86_64',
  '1.3.0' => 'http://files.vagrantup.com/packages/0224c6232394680971a69d94dd55a7436888c4cb/vagrant_1.3.0_x86_64',
  '1.2.7' => 'http://files.vagrantup.com/packages/7ec0ee1d00a916f80b109a298bab08e391945243/vagrant_1.2.7_x86_64',
  '1.2.6' => 'http://files.vagrantup.com/packages/22b76517d6ccd4ef232a4b4ecbaa276aff8037b8/vagrant_1.2.6_x86_64',
  '1.2.5' => 'http://files.vagrantup.com/packages/ec2305a9a636ba8001902cecb835a00e71a83e45/vagrant_1.2.5_x86_64',
  '1.2.4' => 'http://files.vagrantup.com/packages/0219bb87725aac28a97c0e924c310cc97831fd9d/vagrant_1.2.4_x86_64',
  '1.2.3' => 'http://files.vagrantup.com/packages/95d308caaecd139b8f62e41e7add0ec3f8ae3bd1/vagrant_1.2.3_x86_64',
  '1.2.2' => 'http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_x86_64',
  '1.2.1' => 'http://files.vagrantup.com/packages/a7853fe7b7f08dbedbc934eb9230d33be6bf746f/vagrant_1.2.1_x86_64',
  '1.2.0' => 'http://files.vagrantup.com/packages/f5ece47c510e5a632adb69701b78cb6dcbe03713/vagrant_1.2.0_x86_64',
}

if system('which vagrant > /dev/null 2>/dev/null')
  puts 'Vagrant already installed'
  exit 0
end

extension = ''
installer = ''
if system('which dpkg > /dev/null 2>/dev/null')
  extension = 'deb'
  installer = 'dpkg -i'
else
  extension = 'rpm'
  installer = 'rpm -U'
end

puts "Installing vagrant #{ARGV[0]}"
if ! system "wget #{VAGRANTS.fetch ARGV[0]}.#{extension} -O /tmp/vagrant.#{extension} -q"
  system "curl -L -o /tmp/vagrant.#{extension} #{VAGRANTS.fetch ARGV[0]}.#{extension}"
end
system "#{installer} /tmp/vagrant.#{extension}"
