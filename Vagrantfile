# Use the directory name as the default hostname
hostname = File.basename(File.dirname(__FILE__));

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = hostname + ".lan"
  config.vm.network "forwarded_port", guest: 80, host: 3333
  config.vm.network "public_network"

  # Enable SSH forwarding
  config.ssh.forward_agent = true

  # Prevent "stdin: not a tty" errors
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Share folders to the guest VM
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
    vb.name = hostname
    vb.memory = 1024
    vb.cpus = 4
    vb.gui = false

    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver2", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy2", "on"]
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
    #puppet.options = "--verbose --debug"
  end
end
