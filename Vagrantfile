# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/centos-6.5"
  config.vm.network "public_network"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision "shell", path: "openvz.sh"
  config.vm.provision "shell", path: "owp.sh"
end
