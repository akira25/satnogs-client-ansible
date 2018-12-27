# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Configure 'debian'
  config.vm.define :debian do |debian|

    # Disable sharing of project folder
    config.vm.synced_folder ".", "/vagrant", disabled: true

    # Set preferred provider
    config.vm.provider "libvirt" do |domain|
      domain.memory = "1024"
      domain.cpus = "2"
    end

    # Set box and hostname
    config.vm.box = "debian/stretch64"
    config.vm.hostname = "debian"

    # Execute shell provisioning script
    config.vm.provision "shell", path: ".vagrant-provision.sh", args: "debian"

    # Execute Ansible provisioning
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.groups = {
        "satnogs-setups" => ["debian"],
        "satnogs-radios" => ["debian"],
        "hamlib-utils" => ["debian"],
        "satnogs-clients" => ["debian"]
      }
    end
  end

end
