# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/focal64"

# Database Configuration
  config.vm.define "DB" do |db|
    db.vm.provider :virtualbox do |vb|
      vb.name = "DB"
      vb.memory = 1024
    end

    db.vm.network "private_network", ip: "10.10.17.11"
    db.vm.hostname = "DB"
    db.vm.provision :shell, path: "db_provision.sh"
    
  end

# Web Server Configuration
config.vm.define "Web" do |web|
  web.vm.provider :virtualbox do |vb|
    vb.name = "Web"
    vb.memory = 2048
  end

  web.vm.network "private_network", ip: "10.10.17.12"
  web.vm.hostname = "Web"
  web.vm.provision :shell, path: "web_provision.sh"

  end

end