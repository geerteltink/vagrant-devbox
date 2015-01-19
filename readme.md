# Vagrant DevBox

Vagrant DevBox is a development environment customized for our own needs.

## What's Installed?

- Ubuntu Trusty (14.04)
- Apache 2.4.x
- MySQL 5.5.x
- PHP 5.5.x
- PhpMyAdmin
- Xdebug
- PhantomJS (running as a deamon)

## Prerequisites

- [Composer](http://getcomposer.org/)
- [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html)
- [VirtualBox](https://www.virtualbox.org/)

## Getting Started

This is a fairly simple project to get up and running. The procedure for starting up a working development environment is as follows:

1. Clone the project.
2. Run the command ``vagrant up`` from the directory.
3. Open your browser to http://localhost:3333/.

## Working with the environment

You can access your vagrant box at ``http://localhost:3333/``.

The root user and MySQL root password is ``vagrant``.

MySQL database, username and password are the same as the hostname configured in the Vagrantfile.

You can access phpMyAdmin: ``http://localhost:3333/phpmyadmin/``.

## Vagrant commands

    // Start or resume your server
    vagrant up

    // Pause your server
    vagrant suspend

    // Delete your server
    vagrant destroy

    // SSH into your server
    vagrant ssh
