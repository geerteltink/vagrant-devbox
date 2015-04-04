Vagrant DevBox
==============

Vagrant DevBox is a development environment customized for our own needs.

What's Installed?
-----------------

By default the vagrant box runs Ubuntu Trusty (14.04), Apache, MySQL, PHP, PhpMyAdmin and more... For a full list take a look at [vagrant-puppet](https://github.com/twentyfirsthall/vagrant-puppet).

Prerequisites
-------------

- [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html)
- [VirtualBox](https://www.virtualbox.org/)

Getting Started
---------------

This is a fairly simple project to get up and running. The procedure for starting up a working development environment is as follows:

1. Create a new project: `composer create-project twentyfirsthall/vagrant-devbox <project-path>`
2. Run the command `vagrant up` from the directory.
3. Open your browser to `http://localhost:3333/`.

Working with the environment
----------------------------

You can access your vagrant box at `http://localhost:3333/`.

You can access phpMyAdmin: `http://localhost:3333/phpmyadmin/`. The MySQL database, username and password are `vagrant`. They can be customized in a `build/vagrant.yaml` file.

Specific configurations
-----------------------

There are specific wordpress and phpbb configuration files included in the `build` dir. Simply copy these file to your `<project_root>` dir (where this file is located) and run composer.

Vagrant commands
----------------

    // Start or resume the server
    vagrant up

    // SSH into your server
    vagrant ssh

    // Stop the server
    vagrant halt

    // Delete your server
    vagrant destroy
