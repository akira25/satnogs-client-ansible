# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

host_vars = YAML.load_file("production/inventory/host_vars/satnogs/main.yml")

Vagrant.configure("2") do |config|

  # Configure 'debian_bullseye'
  config.vm.define :debian_bullseye do |debian_bullseye|

    # Disable sharing of project folder
    debian_bullseye.vm.synced_folder ".", "/vagrant", disabled: true

    # Set preferred provider
    debian_bullseye.vm.provider "libvirt" do |domain|
      domain.memory = "1024"
      domain.cpus = "2"
    end

    # Set box and hostname
    debian_bullseye.vm.box = "debian/bullseye64"
    debian_bullseye.vm.hostname = "debian-bullseye"

    # Execute shell pre-provisioning script
    debian_bullseye.vm.provision "shell", path: ".vagrant-provision.sh", args: ["pre", "debian_bullseye"]

    # Execute Ansible provisioning
    debian_bullseye.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.host_vars = {
        "debian_bullseye" => host_vars
      }
      ansible.groups = {
        "satnogs_setups" => ["debian_bullseye"],
        "satnogs_radios" => ["debian_bullseye"],
        "hamlib_utils" => ["debian_bullseye"],
        "satnogs_clients" => ["debian_bullseye"],
        "snmpds" => ["debian_bullseye"],
        "gpsds" => ["debian_bullseye"]
      }
    end

    # Execute shell post-provisioning script
    debian_bullseye.vm.provision "shell", path: ".vagrant-provision.sh", args: ["post", "debian_bullseye"]

  end

end
