BCCVL_Test_Environment
======================

A series of scripts and Git submodules to allow for the automated generation of local VMs

Getting Started
=========================

Welcome... Let's get straight into it.

This guide assumes you just freshly cloned this repo.

1. You need to pull the submodules into this repo:

		git submodule update --init

   You can update all the submodules using the following command:

		git submodule foreach git pull origin master

2. Install vagrant guest additions plugin. This
ensures that your VMs guest additions are up to date - if you don't use this, you'll
need to manage the guest additions on your VMs yourself.

		vagrant plugin install vagrant-vbguest

3. Install salty-vagrant plugin. (Unless already installed)

		vagrant plugin install vagrant-salt

4. Bring up the VMs:

		vagrant up

5. Restart the Plone VM. Once the plone VM is up, and the provisioning is complete,
you should restart it. This will ensure that all the necessary services are started
correctly.

		vagrant halt plone && sleep 10 && vagrant up plone


Testing Plone
==========================

Note: This assumes you have finished the getting started steps, your VM is up, and has already been fully provisioned.
Don't attempt these steps until provisioning is complete, and you have restarted the Plone VM.

1. Log into the Plone VM:

		vagrant ssh plone

2. Switch to the plone user:

		sudo su plone

3. Start Plone:

		cd ~/bccvl_buildout && ./bin/instance-debug fg

4. Hit up plone in your browser (this can be from your local (host) machine):

		http://192.168.100.100/


Testing The Visualiser
==========================
