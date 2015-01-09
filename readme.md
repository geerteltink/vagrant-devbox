# Vagrant DevBox

## Installation

- Install [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html) on your system

- Install [VirtualBox](https://www.virtualbox.org/) or [another provider](https://docs.vagrantup.com/v2/getting-started/providers.html)

## Vagrant commands

Start up Vagrant

    $ vagrant up

In less than a minute, this command will finish and you'll have a virtual machine running. You won't actually see anything though, since Vagrant runs the virtual machine without a UI. To prove that it is running, you can SSH into the machine:

    $ vagrant ssh

All files are shared in ``/vagrant`` and symlinked to ``/var/www``.

Suspending the virtual machine will save the current running state of the machine and stop it. When you're ready to begin working again, just run vagrant up, and it will be resumed from where you left off. The main benefit of this method is that it is super fast, usually taking only 5 to 10 seconds to stop and start your work. The downside is that the virtual machine still eats up your disk space, and requires even more disk space to store all the state of the virtual machine RAM on disk.

    $ vagrant suspend

Halting the virtual machine will gracefully shut down the guest operating system and power down the guest machine. You can use vagrant up when you're ready to boot it again. The benefit of this method is that it will cleanly shut down your machine, preserving the contents of disk, and allowing it to be cleanly started again. The downside is that it'll take some extra time to start from a cold boot, and the guest machine still consumes disk space.

    $ vagrant halt

Destroying the virtual machine will remove all traces of the guest machine from your system. It'll stop the guest machine, power it down, and remove all of the guest hard disks. Again, when you're ready to work again, just issue a vagrant up. The benefit of this is that no cruft is left on your machine. The disk space and RAM consumed by the guest machine is reclaimed and your host machine is left clean. The downside is that vagrant up to get working again will take some extra time since it has to reimport the machine and reprovision it.

    $ vagrant destroy
