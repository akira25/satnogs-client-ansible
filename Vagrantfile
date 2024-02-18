# -*- mode: ruby -*-
# vi: set ft=ruby :

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
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "site.yml"
    end

    # Execute shell post-provisioning script
    debian_bullseye.vm.provision "shell", path: ".vagrant-provision.sh", args: ["post", "debian_bullseye"]

  end

end
