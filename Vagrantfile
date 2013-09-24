# -*- mode: ruby -*-
# vi: set ft=ruby :

USER = 'vagrant'

# Use vagrant version 2
Vagrant.configure("2") do |config|

  ##########################
  #    UNIVERSAL CONFIG    #
  ##########################

  # All machines will use a common CentOS-6 (64 bit) base
  config.vm.box     = "centos-64-x64-vbox4210"
  # Use the box provided by puppetlabs (this is just CentOS-6 with puppet pre-installed)
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

  config.vm.synced_folder "salt/roots/", "/srv/"


  ##########################
  #    PLONE VM CONFIG     #
  ##########################
  config.vm.define :plone do |plone|
      plone.vm.network :private_network, ip: "192.168.100.100"

      # Overide default virtualbox config options
      plone.vm.provider :virtualbox do |vb|
        # Give the VM 2GB of memory
        vb.customize ["modifyvm", :id, "--memory", "2048"]
      end

      plone.vm.hostname = "plone"

      plone.vm.provision :salt do |salt|
        salt.minion_config = "salt/plone_minion"
        salt.run_highstate = true
        salt.verbose = true

        salt.install_type = 'git'
        salt.install_args = 'v0.16.0'
      end
  end


  ##########################
  #  VISUALISER VM CONFIG  #
  ##########################
  config.vm.define :visualiser do |visualiser|
      visualiser.vm.network :private_network, ip: "192.168.100.101"
      visualiser.vm.hostname = "visualiser"

      visualiser.vm.provision :salt do |salt|
        salt.minion_config = "salt/visualiser_minion"
        salt.run_highstate = true
        salt.verbose = true

        salt.install_type = 'git'
        salt.install_args = 'v0.16.0'
      end
  end


  ##########################
  #  DATA MOVER VM CONFIG  #
  ##########################
  config.vm.define :data_mover do |data_mover|
      data_mover.vm.network :private_network, ip: "192.168.100.102"
      data_mover.vm.hostname = "data-mover" # hostname can't contain underscores :(

      data_mover.vm.provision :salt do |salt|
        salt.minion_config = "salt/data_mover_minion"
        salt.run_highstate = true
        salt.verbose = true

        salt.install_type = 'git'
        salt.install_args = 'v0.16.0'
      end
  end

  ##########################
  #   COMBINED VM CONFIG   #
  ##########################
  config.vm.define :combined do |combined|
      combined.vm.network :private_network, ip: "192.168.100.200"
      combined.vm.hostname = "combined"

      # Overide default virtualbox config options
      combined.vm.provider :virtualbox do |vb|
        # Give the VM 2GB of memory
        vb.customize ["modifyvm", :id, "--memory", "2048"]
      end

      combined.vm.provision :salt do |salt|
        salt.minion_config = "salt/combined_minion"
        salt.run_highstate = true
        salt.verbose = true

        salt.install_type = 'git'
        salt.install_args = 'v0.16.0'
      end
  end

end
