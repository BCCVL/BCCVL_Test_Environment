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
Don't attempt these steps until provisioning is complete, and you have restarted the Plone VM. The VM
may need a few moments to start the httpd and supervisord services prior to your interaction.

Note: In some cases, the VM can require multiple restarts. This is an issue in provisioning that is currently under investiagation.

Once provisioning is successfully completed and the VM has started all necessary
services, the VM will allow for interaction with a production instance environment at:

		https://192.168.100.100/

Once this URL responds with a Plone interface that has reference data sets, experiments, etc.
you can be confident that your plone VM is ready, all the necessary services are running.

Note: This production instance is behind a cache layer (varnish).


Development Instance
--------------------------

The following describes how to interact with a development instance, which should be
free of any cache layers. You should ensure that the production instance is responding
before setting up the development instance. If you don't, your VM may not have all
the necessary services running when you try start your development instance.


1. Log into the Plone VM:

		vagrant ssh plone

2. Switch to the plone user:

		sudo su plone

3. Start Plone:

		cd ~/bccvl_buildout && ./bin/instance-debug fg

4. Hit the development instance of plone in your browser (this can be from your local _host_ machine):

		http://192.168.100.100/


Testing The Visualiser
==========================
