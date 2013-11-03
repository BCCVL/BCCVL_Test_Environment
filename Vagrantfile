# -*- mode: ruby -*-
# vi: set ft=ruby :

USER = 'vagrant'

# Use vagrant version 2
Vagrant.configure("2") do |config|

  ##########################
  #    UNIVERSAL CONFIG    #
  ##########################

  config.vm.synced_folder "salt/roots/", "/srv/"


  ##########################
  #    PLONE VM CONFIG     #
  ##########################
  config.vm.define :plone do |plone|

      plone.vm.box     = "centos-64-x64-vbox4210"
      plone.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

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

      visualiser.vm.box     = "centos-64-x64-vbox4210"
      visualiser.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

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

      data_mover.vm.box     = "centos-64-x64-vbox4210"
      data_mover.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

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

      combined.vm.box     = "centos-64-x64-vbox4210"
      combined.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

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

  #################################
  #   NECTAR COMBINED VM CONFIG   #
  #################################
  #
  # Dependencies
  # ----------------------------
  #
  # 1. vagrant plugin install vagrant-salt
  # 2. vagrant plugin install vagrant-openstack-plugin
  #
  #
  # Controlling the open stack VM
  # -----------------------------
  #
  # To start the VM:
  #     vagrant up nectar_bccvl_combined --provider=openstack
  #
  # To destroy the VM:
  #     vagrant destroy nectar_bccvl_combined
  #
  # To re-provision an already up VM:
  #     vagrant provision nectar_bccvl_combined
  #
  # To restart the VM:
  #     vagrant ssh nectar_bccvl_combined
  #     reboot
  #
  # To shutown the VM:
  #     vagrant ssh nectar_bccvl_combined
  #     shutdown now
  #
  #
  # Configuring the VM
  # ----------------------
  #
  # You'll need to change:
  #
  # os.username -> your nectar email
  #
  # os.api_key -> your nectar API key
  #
  #     Go to settings in Nectar, and click reset password.
  #     This will generate your API Key
  #
  # os.keypair_name -> The keypair you intend to use
  #
  #     The one you added for your current machine.
  #
  # os.tenant -> Your Nectar project
  #
  #     Probably pt-####
  #
  # os.security_groups -> The security groups you intend to use
  #
  #     Make sure you at least have ssh and rsync open.
  #
  config.vm.define :nectar_bccvl_combined do |nectar_bccvl_combined|

    # The box isn't used (hence it's just a dummy box)
    nectar_bccvl_combined.vm.box     = "dummy"
    nectar_bccvl_combined.vm.box_url = "https://github.com/cloudbau/vagrant-openstack-plugin/raw/master/dummy.box"

    nectar_bccvl_combined.ssh.private_key_path = "~/.ssh/id_rsa"

    nectar_bccvl_combined.vm.provider :openstack do |os|
      # Change these...
      os.username     = "YOUR_EMAIL@uni.edu.au"
      os.api_key      = "YOUR_API_KEY"
      os.keypair_name = "YOUR KEYPAIR NAME"
      os.tenant       = "pt-####"

      os.flavor       = /m1.small/
      os.image        = "0debdc10-1eeb-4239-8177-3e756c2758c9"
      os.endpoint     = "https://keystone.rc.nectar.org.au:5000/v2.0/tokens"
      os.ssh_username = "ec2-user"

      os.security_groups   = ['ssh', 'http', 'icmp', 'rsync']
      os.availability_zone = "monash"
    end

    nectar_bccvl_combined.vm.provision :salt do |salt|
      salt.minion_config = "salt/combined_minion"
      salt.run_highstate = true
      salt.verbose = true

      salt.install_type = 'git'
      salt.install_args = 'v0.16.0'
    end
  end

end
