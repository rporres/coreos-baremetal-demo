# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  hostname = "provisioner-1.infra.local"
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = hostname
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
  end

  internal_ip = "192.168.1.1"
  config.vm.network "private_network", ip: internal_ip,
    virtualbox__intnet: true

  config.vm.provision "shell", path: "scripts/provision.sh",
    args: [ internal_ip ]

end
