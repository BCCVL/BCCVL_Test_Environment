BCCVL_Test_Environment
======================

A series of scripts and Git submodules to allow for the automated generation of local VMs

Getting Started
=========================

Welcome... Let's get straight into it.

This guide assumes you just freshly cloned this repo.

1. You need to pull the submodules into this repo:

		git submodule update --init

2. Install vagrant guest additions plugin. This
ensures that your VMs guest additions are up to date - if you don't use this, you'll
need to manage the guest additions on your VMs yourself.

		vagrant plugin install vagrant-vbguest

3. Bring up the VMs:

		vagrant up
