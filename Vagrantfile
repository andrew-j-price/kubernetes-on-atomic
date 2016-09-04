# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

require 'yaml'
servers = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  servers.each do |servers|
    config.vm.define servers["name"] do |srv|
      srv.vm.box = servers["box"]
      srv.vm.hostname = servers["name"]
      srv.vm.network "private_network", ip: servers["ip"], :adapter => 2
      srv.vm.provider :virtualbox do |vb|
        vb.memory = servers["ram"]
        vb.cpus = servers["cpus"]
      end
      srv.vm.provision "shell", inline: $keys
    end
  end
  config.vm.define :nucleus do |config|
    config.vm.box = "centos/7"
    config.vm.hostname = "nucleus"
    config.vm.network :private_network, ip: "192.168.56.90", :adapter => 2
    config.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
    config.vm.provision "shell", inline: $deploy
  end
end

$keys = <<SCRIPT
  sudo mkdir /root/.ssh/
  sudo cp /var/home/vagrant/sync/authorized_keys /root/.ssh/authorized_keys
  cat /var/home/vagrant/sync/authorized_keys >> /home/vagrant/.ssh/authorized_keys
SCRIPT

$deploy = <<SCRIPT
  sudo mkdir /root/.ssh/
  sudo cp /vagrant/authorized_keys /root/.ssh/authorized_keys
  cat /vagrant/authorized_keys >> /home/vagrant/.ssh/authorized_keys
  sudo yum -y install epel-release
  sudo yum -y update
  sudo yum -y install ansible
  cd /vagrant/
  ansible-playbook play.yml
SCRIPT
