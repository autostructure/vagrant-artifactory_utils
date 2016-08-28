# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  # Synched Folder.
  synched_opts = { nfs: true }
  nfs_exports = ["rw", "noac", "actimeo=0", "intr", "async", "insecure", "no_subtree_check", "noacl", "lookupcache=none"]

  if RUBY_PLATFORM =~ /darwin/
    nfs_exports << "maproot=0:0"
    synched_opts[:bsd__nfs_options] = nfs_exports
  elsif RUBY_PLATFORM =~ /linux/
    nfs_exports << "no_root_squash"
    synched_opts[:linux__nfs_options] = nfs_exports
  end

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'puppetlabs/centos-7.2-64-puppet'
  config.vm.provision :hosts, sync_hosts: true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider 'virtualbox' do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = 1024
  end

  config.vm.provider 'vmware_fusion' do |v|
    # Customize the amount of memory on the VM:
    v.vmx['memsize'] = 1024
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  install_puppet_script = <<SCRIPT
yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
/opt/puppetlabs/bin/puppet module install puppetlabs-firewall
SCRIPT

  config.vm.provision :shell,
                      inline: install_puppet_script

  config.vm.define :database do |database|
    database.vm.network "private_network", ip: '10.20.1.2'

    # Provision the database
    install_artifactory_mysql = <<SCRIPT
/opt/puppetlabs/bin/puppet module install puppetlabs-mysql
/opt/puppetlabs/bin/puppet apply /vagrant/manifests/artifactory_mysql.pp --modulepath=/etc/puppetlabs/code/environments/production/modules
SCRIPT

    database.vm.provision :shell,
                          inline: install_artifactory_mysql
  end

  config.vm.define :artifactory0 do |artifactory0|
    artifactory0.vm.synced_folder "nfs_area", "/nfs/mount", synched_opts

    artifactory0.vm.network "private_network", ip: '10.20.1.3'

    # Provision the database
    install_artifactory = <<SCRIPT
/opt/puppetlabs/bin/puppet module install autostructure-artifactory_ha
/opt/puppetlabs/bin/puppet apply /vagrant/manifests/artifactory_server_primary.pp --modulepath=/etc/puppetlabs/code/environments/production/modules
SCRIPT

    artifactory0.vm.provision :shell,
                              inline: install_artifactory
  end

  config.vm.define :artifactory1 do |artifactory1|
    artifactory1.vm.synced_folder "nfs_area", "/nfs/mount", synched_opts

    artifactory1.vm.network "private_network", ip: '10.20.1.4'

    # Provision the database
    install_artifactory = <<SCRIPT
/opt/puppetlabs/bin/puppet module install autostructure-artifactory_ha
/opt/puppetlabs/bin/puppet apply /vagrant/manifests/artifactory_server_secondary.pp --modulepath=/etc/puppetlabs/code/environments/production/modules
SCRIPT

    artifactory1.vm.provision :shell,
                              inline: install_artifactory
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
