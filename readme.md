Vagrant DevBox
==============

Vagrant DevBox is a local development environment. All necessary tools are inside the virtual machine, configured and waiting to be used. All you need to do is startup the vagrant box and SSH into it. Files can be created / modified outside the vagrant box with your favorite editor. All other commands can / should be run inside the virtual machine.

What's Installed?
-----------------

The vagrant box runs on Ubuntu Trusty (14.04) with Apache, MySQL, PHP and more... For a full list take a look at [vagrant-puppet](https://github.com/twentyfirsthall/vagrant-puppet).

Prerequisites
-------------

- [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html)
- [VirtualBox](https://www.virtualbox.org/)
- [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) (optional) Reduce the amount of coffee you drink while waiting for boxes to be provisioned.
- [vagrant-winnfsd](https://github.com/GM-Alex/vagrant-winnfsd) (optional, windows only!) Enable NFS synced folders support on windows.

By default agent forwarding over SSH connections is enabled. On the host system you need to have `ssh-agent` running with your key(s) added. If the agent is running, tools like git will just work without importing your valuable keys into the vagrant box.

Getting Started
---------------

This is a fairly simple project to get up and running. The procedure for starting up a working development environment is as follows:

1. Create a new project: `composer create-project twentyfirsthall/vagrant-devbox <project-path>`
2. Run the command `vagrant up` from the directory.
3. Open your browser to `http://localhost:8000/`.

Working with the environment
----------------------------

You can access your vagrant box at `http://localhost:8000/` or `http://192.168.10.10/`.

The source code can be found at `/vagrant`. The website is served from `/vagrant/public`.

The MySQL database, username and password is `vagrant`. They can be customized in the optional `build/vagrant.yaml` file.

Specific configurations
-----------------------

There are specific wordpress and phpbb configuration files included in the `build` dir. Simply copy these file to your `<project_root>` dir (where this file is located) and run composer.

Vagrant commands
----------------

    // Start or resume the vagrant box
    vagrant up

    // SSH into the vagrant box
    vagrant ssh

    // Shut down the vagrant box
    vagrant halt

    // Updating the box on startup once in a while might be a good idea
    vagrant up --provision
    // Update the box while it is running
    vagrant provision

    // Delete the vagrant box (the image only, not any git controlled source files)
    vagrant destroy
