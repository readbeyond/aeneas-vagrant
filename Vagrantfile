# -*- mode: ruby -*-
# vi: set ft=ruby :

# Author: Alberto Pettarin
# Copyright: 2015-2016, Alberto Pettarin (www.albertopettarin.it)
# License: GNU AGPL v3
# Version: 1.6.0
# Email: aeneas@readbeyond.it
# Status: Production

Vagrant.configure(2) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.box_check_update = false
  
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"
  
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    #vb.gui = true
    # Display with this VM name:
    vb.name = "aeneas"
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
    # vb.cpus = 2
  end

  config.vm.provision :shell, path: "setup.sh"
end
