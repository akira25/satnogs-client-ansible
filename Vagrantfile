# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Configure 'debian'
  config.vm.define :debian do |debian|

    # Disable sharing of project folder
    debian.vm.synced_folder ".", "/vagrant", disabled: true

    # Set preferred provider
    debian.vm.provider "libvirt" do |domain|
      domain.memory = "1024"
      domain.cpus = "2"
    end

    # Set box and hostname
    debian.vm.box = "debian/stretch64"
    debian.vm.hostname = "debian"

    # Execute shell provisioning script
    debian.vm.provision "shell", path: ".vagrant-provision.sh", args: "debian"

    # Execute Ansible provisioning
    debian.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.groups = {
        "satnogs-setups" => ["debian"],
        "satnogs-radios" => ["debian"],
        "hamlib-utils" => ["debian"],
        "satnogs-clients" => ["debian"],
        "snmpds" => ["debian"]
      }
    end
  end

end
