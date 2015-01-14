# Vagrant DevBox

## Installation

- Install [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html) on your system

- Install [VirtualBox](https://www.virtualbox.org/) or [another provider](https://docs.vagrantup.com/v2/getting-started/providers.html)

## Vagrant commands

    // Start or resume your server
    vagrant up

    // Pause your server
    vagrant suspend

    // Delete your server
    vagrant destroy

    // SSH into your server
    vagrant ssh

Access your vagrant box at ``http://localhost:3333/``.

MySQL root password is ``vagrant``.
MySQL database, username and password are the same as the hostname configured in the Vagrantfile.
