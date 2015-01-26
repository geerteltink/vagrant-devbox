# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

hostname = "devbox"

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = hostname + ".lan"
  config.vm.network "forwarded_port", guest: 80, host: 3333
  config.vm.network "public_network"

  config.vm.provider "virtualbox" do |vb|
    vb.name = hostname
    #vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver2", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy2", "on"]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "vendor/twentyfirsthall/vagrant-puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "vendor/twentyfirsthall/vagrant-puppet/modules"
    #puppet.options = "--verbose --debug"
  end
end
