BCCVL_Test_Environment
======================

A series of scripts and Git submodules to allow for the automated generation of local VMs


Getting Started
=========================

Welcome... Let's get straight into it.

This guide assumes you just freshly cloned this repo.

1. Install vagrant guest additions plugin. This ensures that your VMs 
guest additions are up to date - if you don't use this, you'll
need to manage the guest additions on your VMs yourself.

		vagrant plugin install vagrant-vbguest

2. Install salty-vagrant plugin. (Unless already installed)

		vagrant plugin install vagrant-salt

3. Bring up the combined VM:

		vagrant up combined


VMs
------------------

The following are the different VMs that we support. Unless you have special
requirements, just use the combined VM.

| VM            | Vagrant VM Name  | IP              | Git Hub Repo                                      |
| ------------- |:----------------:|:---------------:| -------------------------------------------------:|
| Plone         | plone            | 192.168.100.100 | https://github.com/BCCVL/org.bccvl.site, et al.   |
| Visualiser    | visualiser       | 192.168.100.101 | https://github.com/BCCVL/BCCVL_Visualiser         |
| Data Manager  | data_manager     | 192.168.100.102 | https://github.com/BCCVL/bccvl_data_mover         |
| Combined      | combined         | 192.168.100.200 | N/A                                               |


Testing Plone
==========================

Note: This assumes you have finished the getting started steps, your VM is up, and has already been fully provisioned.

The VM may take up to five minutes to start all the necessary services. The apache service
will start up relatively quickly, and then you will receive a
503 status while the supervisord (plone) services are starting up.

Once provisioning is successfully completed and the VM has started all necessary
services, the VM will allow for interaction with a production instance environment at:

		https://192.168.100.200/

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

		vagrant ssh combined

2. Switch to the plone user:

		sudo su plone

3. Start Plone:

		cd ~/bccvl_buildout && ./bin/instance-debug fg

4. Hit the development instance of plone in your browser (this can be from your local _host_ machine):

		https://192.168.100.200/_debug/bccvl


Testing The Visualiser
==========================

Note: This assumes you have finished the getting started steps, your VM is up, and has already been fully provisioned.

1. Hit the visualiser in your browser (this can be from your local _host_ machine):

		http://192.168.100.200/_visualiser/api.text

Once this URL responds with a listing of the available visualiser apis, you can be
confident that the visualiser is started.

Testing The Data Mover
==========================

Note: This assumes you have finished the getting started steps, your VM is up, and has already been fully provisioned.

1. start an interactive python prompt

		python

2. run the following python

		from xmlrpclib import ServerProxy
		s = ServerProxy('http://192.168.100.200/_data_mover/data_mover')
		lsid = 'urn:lsid:biodiversity.org.au:afd.taxon:31a9b8b8-4e8f-4343-a15f-2ed24e0bf1ae'
		lsid = 'urn:lsid:biodiversity.org.au:afd.taxon:31a9b8b8-4e8f-4343-a15f-2ed24e0bf1ae'
		s.pullOccurrenceFromALA(lsid)

You can be confident the data_mover is up if you receive something like the following:

		{'status': 'PENDING', 'id': 1}
