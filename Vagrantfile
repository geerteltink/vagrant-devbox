hostname = "devbox"
memory = 1024
cpus = 4
gui = false

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = hostname + ".lan"
  config.vm.network "forwarded_port", guest: 80, host: 3333
  config.vm.network "public_network"

  # Enable SSH forwarding
  config.ssh.forward_agent = true

  # Prevent "stdin: not a tty" errors
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  #config.vm.synced_folder ".", "/vagrant", type: "nfs",  mount_options: ['rw', 'vers=3', 'tcp', 'fsc' ,'actimeo=2']
  #config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
    vb.name = hostname
    vb.memory = memory
    vb.cpus = cpus
    vb.gui = gui

    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver2", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy2", "on"]
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.provision :puppet do |puppet|
    puppet.hiera_config_path = "vendor/twentyfirsthall/vagrant-puppet/manifests/hiera.yaml"
    puppet.manifests_path = "vendor/twentyfirsthall/vagrant-puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "vendor/twentyfirsthall/vagrant-puppet/modules"
    #puppet.options = "--verbose --debug"
  end
end
