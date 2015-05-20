#
# Vagrant devbox
#
# To set the virtual machine project settings, copy `vendor/xtreamwayz/vagrant-puppet/hieradata/default.yaml`
# to `<project_path>/vagrant.yaml`.
#
# Personal settings can be stored in `~/.devbox/vagrant.yaml`.
#
# Vagrant settings are merged in this order:
#   - `<project_path>/vendor/xtreamwayz/vagrant-puppet/hieradata/default.yaml`
#   - `<project_path>/vagrant.yaml`
#   - `~/.devbox/vagrant.yaml`
#

require 'yaml'

# Use the directory name as the default box name
display_name = File.basename(File.dirname(__FILE__))

# Load default settings
default_yaml = File.join(__dir__, "vendor/xtreamwayz/vagrant-puppet/hieradata/default.yaml")
settings = YAML.load_file(default_yaml)

# Load project settings if any
project_yaml = File.join(__dir__, "/vagrant.yaml")
if File.exist?(project_yaml)
    project_settings = YAML::load_file(project_yaml)
    settings.merge!(project_settings)
    puts "Project configuration merged from .vagrant.yaml"
end

# Load user settings if any
user_yaml = File.join(File.expand_path("~/.devbox"), "/vagrant.yaml")
if File.exist?(user_yaml)
    user_settings = YAML::load_file(user_yaml)
    settings.merge!(user_settings)
    puts "User configuration merged from ~/.devbox/vagrant.yaml"
end

# Write settings to hiera config file
File.open(".vagrant/config.yaml", "w") {|f| f.write(settings.to_yaml) }

#puts YAML::dump(settings)

Vagrant.configure(2) do |config|
  # Set the vm provider
  ENV['VAGRANT_DEFAULT_PROVIDER'] = settings["vagrant"]["provider"] ||= "virtualbox"

  # Configure the box
  config.vm.box = settings["vagrant"]["box"] ||= "ubuntu/trusty64"
  config.vm.hostname = settings["vagrant"]["hostname"] ||= display_name + ".lan"

  # Configure a private network, needed for NFS synced folders
  config.vm.network :private_network, ip: settings["vagrant"]["ip"] ||= "192.168.10.10"

  # Configure port forwarding
  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 443, host: 44300
  config.vm.network "forwarded_port", guest: 3306, host: 33060

  # Setup synced folders
  if settings["vagrant"].include? "folders"
    settings["vagrant"]["folders"].each do |folder|
      mount_opts = folder["type"] == "nfs" ? ["rw,nolock,vers=3,actimeo=1"] : []
      config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil, mount_options: mount_opts
    end
  end

  # Enable SSH forwarding
  config.ssh.forward_agent = true

  # Prevent "stdin: not a tty" errors
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Configure VirtualBox settings
  config.vm.provider "virtualbox" do |vb|
    vb.name = display_name
    vb.gui = settings["vagrant"]["gui"] ||= false
    vb.customize ["modifyvm", :id, "--memory", settings["vagrant"]["memory"] ||= "2048"]
    vb.customize ["modifyvm", :id, "--cpus", settings["vagrant"]["cpus"] ||= "1"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # Configure VMware settings
  ["vmware_fusion", "vmware_workstation"].each do |vmware|
    config.vm.provider vmware do |v|
      v.vmx["displayName"] = display_name
      v.vmx["memsize"] = settings["vagrant"]["memory"] ||= 2048
      v.vmx["numvcpus"] = settings["vagrant"]["cpus"] ||= 1
    end
  end

  # A Vagrant plugin that helps you reduce the amount of coffee you drink while
  # waiting for boxes to be provisioned by sharing a common package cache among
  # similiar VM instances. Install with: `vagrant plugin install vagrant-cachier`
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # Shell provisioners to do necessary prep for subsequent puppet provisioning
  config.vm.provision :shell, :inline => "/usr/bin/apt-get install -y software-properties-common puppet libaugeas-ruby augeas-tools ruby"

  # Enable provisioning with Puppet stand alone.
  config.vm.provision :puppet do |puppet|
    puppet.hiera_config_path = "vendor/xtreamwayz/vagrant-puppet/hieradata/hiera.yaml"
    puppet.manifests_path = "vendor/xtreamwayz/vagrant-puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "vendor/xtreamwayz/vagrant-puppet/modules"
    puppet.options = settings["vagrant"]["puppet_options"] ||= ""
  end
end
