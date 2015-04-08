#
# Vagrant devbox
#
# To customize your virtual machine, copy `vendor/twentyfirsthall/vagrant-puppet/hieradata/default.yaml`
# to `build/vagrant.yaml`. Vagrant settings are merged.
#
# Puppet module settings are overwritten per key. So if you want to change `apache::vhosts:`, you need to
# configure the complete key and not just set `apache::vhosts::vagrant::port`.
#

require 'yaml'

# Use the directory name as the default box name
display_name = File.basename(File.dirname(__FILE__))

# Load default settings
default_yaml = File.join(__dir__, "vendor/twentyfirsthall/vagrant-puppet/hieradata/default.yaml")
settings = YAML.load_file(default_yaml)["vagrant"]

# Load custom settings if any
vagrant_yaml = File.join(__dir__, "build/vagrant.yaml")
if File.exist?(vagrant_yaml)
  custom_settings = YAML::load_file(vagrant_yaml)
  if custom_settings.has_key?("vagrant")
    settings.merge!(custom_settings["vagrant"])
  end
end

Vagrant.configure(2) do |config|
  # Set the vm provider
  ENV['VAGRANT_DEFAULT_PROVIDER'] = settings["provider"] ||= "virtualbox"

  # Configure the box
  config.vm.box = settings["box"] ||= "ubuntu/trusty64"
  config.vm.hostname = settings["hostname"] ||= display_name + ".lan"

  # Configure the network
  #config.vm.network "public_network"
  config.vm.network :private_network, ip: settings["ip"] ||= "192.168.10.10"

  # Configure port forwarding
  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 443, host: 44300
  config.vm.network "forwarded_port", guest: 3306, host: 33060

  # Enable SSH forwarding
  config.ssh.forward_agent = true

  # Prevent "stdin: not a tty" errors
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Configure A Few VirtualBox Settings
  config.vm.provider "virtualbox" do |vb|
    vb.name = display_name
    vb.gui = settings["gui"] ||= false
    vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
    vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # Configure A Few VMware Settings
  ["vmware_fusion", "vmware_workstation"].each do |vmware|
    config.vm.provider vmware do |v|
      v.vmx["displayName"] = display_name
      v.vmx["memsize"] = settings["memory"] ||= 2048
      v.vmx["numvcpus"] = settings["cpus"] ||= 1
    end
  end

  # A Vagrant plugin that helps you reduce the amount of coffee you drink while
  # waiting for boxes to be provisioned by sharing a common package cache among
  # similiar VM instances.
  #
  # Install with: `vagrant plugin install vagrant-cachier`
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # Shell provisioners to do necessary prep for subsequent puppet provisioning
  config.vm.provision :shell, :inline => "/usr/bin/apt-get install -y software-properties-common puppet libaugeas-ruby augeas-tools ruby"

  # Enable provisioning with Puppet stand alone.
  config.vm.provision :puppet do |puppet|
    puppet.hiera_config_path = "vendor/twentyfirsthall/vagrant-puppet/hieradata/hiera.yaml"
    puppet.manifests_path = "vendor/twentyfirsthall/vagrant-puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "vendor/twentyfirsthall/vagrant-puppet/modules"
    puppet.options = settings["puppet_options"] ||= ""
  end
end
