# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # this line causes the VM to be named.
  config.vm.define "tinbox" do |tinbox|

    settings = {
      'src_folder' => "../../src/tinman",
      'hostname' => "tinbox.nanigans.com"
    }

    custom_settings = File.exists?('settings.yml') ? YAML.load_file('settings.yml') : {}

    settings.merge!(custom_settings)

    tinbox.vm.box = "precise64"
    tinbox.vm.box_url = "http://files.vagrantup.com/precise64.box"
    tinbox.ssh.forward_agent = true
    tinbox.vm.network "private_network", ip: "192.168.56.102"
    tinbox.vm.hostname = settings['hostname']
    tinbox.vm.synced_folder settings['src_folder'], "/var/www", {:mount_options => ['dmode=777','fmode=777']}

    # Set timezone
    tinbox.vm.provision :shell, :inline => "echo \"Etc/UTC\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

    # Ports
    tinbox.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true
    tinbox.vm.network :forwarded_port, guest: 5432, host: 5433, auto_correct: true
    tinbox.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true # livereload port

    tinbox.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    tinbox.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "phpbase.pp"
      puppet.module_path = "puppet/modules"
      #puppet.options = "--verbose --debug"
    end

    tinbox.vm.provision :shell, :path => "puppet/scripts/enable_remote_mysql_access.sh"
    tinbox.vm.provision :shell, :inline => "chmod 777 /var/www/app/storage/*"
    tinbox.vm.provision :shell, :inline => "cd /var/www && php artisan migrate --env=tinbox"
    tinbox.vm.provision :shell, :inline => "cd /var/www && php artisan db:seed --env=tinbox"
    tinbox.vm.provision :shell, :inline => "cd /var/www && php artisan ide-helper:generate --env=tinbox"

  end
end