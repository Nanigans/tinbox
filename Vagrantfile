# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.define :tinbox do |tin_config|
        tin_config.vm.box = "precise32"
        tin_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
        tin_config.ssh.forward_agent = true

        # This will give the machine a static IP uncomment to enable
        tin_config.vm.network :private_network, ip: "192.168.56.102"

        #tin_config.vm.network :forwarded_port, guest: 80, host: 8888, auto_correct: true
        tin_config.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true
        tin_config.vm.network :forwarded_port, guest: 5432, host: 5433, auto_correct: true
        # livereload port
        tin_config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true
        tin_config.vm.hostname = "tinbox.nanigans.com"
        tin_config.vm.synced_folder "../../src/tinman", "/var/www", {:mount_options => ['dmode=777','fmode=777']}
        tin_config.vm.provision :shell, :inline => "echo \"America/New_York\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

        tin_config.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--memory", "512"]
        end

        tin_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "phpbase.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
        end

        tin_config.vm.provision :shell, :path => "puppet/scripts/enable_remote_mysql_access.sh"
        tin_config.vm.provision :shell, :inline => "chmod 777 /var/www/app/storage/*"
        tin_config.vm.provision :shell, :inline => "cd /var/www && php artisan migrate --env=tinbox"
        tin_config.vm.provision :shell, :inline => "cd /var/www && php artisan db:seed --env=tinbox"
        tin_config.vm.provision :shell, :inline => "cd /var/www && php artisan ide-helper:generate --env=tinbox"

    end
end