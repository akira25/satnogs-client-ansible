# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Configure 'debian_buster'
  config.vm.define :debian_buster do |debian_buster|

    # Disable sharing of project folder
    debian_buster.vm.synced_folder ".", "/vagrant", disabled: true

    # Set preferred provider
    debian_buster.vm.provider "libvirt" do |domain|
      domain.memory = "1024"
      domain.cpus = "2"
    end

    # Set box and hostname
    debian_buster.vm.box = "debian/buster64"
    debian_buster.vm.hostname = "debian-buster"

    # Execute shell pre-provisioning script
    debian_buster.vm.provision "shell", path: ".vagrant-provision.sh", args: ["pre", "debian_buster"]

    # Execute Ansible provisioning
    debian_buster.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "site.yml"
    end

    # Execute shell post-provisioning script
    debian_buster.vm.provision "shell", path: ".vagrant-provision.sh", args: ["post", "debian_buster"]

  end

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

  # Configure 'debian_bookworm'
  config.vm.define :debian_bookworm do |debian_bookworm|

    # Disable sharing of project folder
    debian_bookworm.vm.synced_folder ".", "/vagrant", disabled: true

    # Set preferred provider
    debian_bookworm.vm.provider "libvirt" do |domain|
      domain.memory = "1024"
      domain.cpus = "2"
    end

    # Set box and hostname
    debian_bookworm.vm.box = "debian/bookworm64"
    debian_bookworm.vm.hostname = "debian-bookworm"

    # Execute shell pre-provisioning script
    debian_bookworm.vm.provision "shell", path: ".vagrant-provision.sh", args: ["pre", "debian_bookworm"]

    # Execute Ansible provisioning
    debian_bookworm.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "site.yml"
    end

    # Execute shell post-provisioning script
    debian_bookworm.vm.provision "shell", path: ".vagrant-provision.sh", args: ["post", "debian_bookworm"]

  end

  # Configure 'ubuntu focal'
  config.vm.define :ubuntu_focal do |ubuntu_focal|

    # Disable sharing of project folder
    ubuntu_focal.vm.synced_folder ".", "/vagrant", disabled: true

    # Set preferred provider
    ubuntu_focal.vm.provider "libvirt" do |domain|
      domain.memory = "1024"
      domain.cpus = "2"
    end

    # Set box and hostname
    ubuntu_focal.vm.box = "ubuntu/focal64"
    ubuntu_focal.vm.hostname = "ubuntu-focal"

    # Execute shell pre-provisioning script
    ubuntu_focal.vm.provision "shell", path: ".vagrant-provision.sh", args: ["pre", "ubuntu_focal"]

    # Execute Ansible provisioning
    ubuntu_focal.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "site.yml"
    end

    # Execute shell post-provisioning script
    ubuntu_focal.vm.provision "shell", path: ".vagrant-provision.sh", args: ["post", "ubuntu_focal"]

  end

  # Configure 'ubuntu jammy'
  config.vm.define :ubuntu_jammy do |ubuntu_jammy|

    # Disable sharing of project folder
    ubuntu_jammy.vm.synced_folder ".", "/vagrant", disabled: true

    # Set preferred provider
    ubuntu_jammy.vm.provider "libvirt" do |domain|
      domain.memory = "1024"
      domain.cpus = "2"
    end

    # Set box and hostname
    ubuntu_jammy.vm.box = "ubuntu/jammy64"
    ubuntu_jammy.vm.hostname = "ubuntu-jammy"

    # Execute shell pre-provisioning script
    ubuntu_jammy.vm.provision "shell", path: ".vagrant-provision.sh", args: ["pre", "ubuntu_jammy"]

    # Execute Ansible provisioning
    ubuntu_jammy.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "site.yml"
    end

    # Execute shell post-provisioning script
    ubuntu_jammy.vm.provision "shell", path: ".vagrant-provision.sh", args: ["post", "ubuntu_jammy"]

  end

end
