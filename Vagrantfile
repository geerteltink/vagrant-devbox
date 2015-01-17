# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

hostname = "devbox"

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = hostname + ".lan"
  config.vm.network "forwarded_port", guest: 80, host: 3333

  config.vm.provider "virtualbox" do |vb|
    #vb.gui = true
    #vb.memory = "1024"
    vb.name = hostname
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = ".puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = ".puppet/modules"
    #puppet.options = "--verbose --debug"
  end
end
