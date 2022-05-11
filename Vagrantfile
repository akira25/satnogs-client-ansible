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

    # Execute shell provisioning script
    debian_buster.vm.provision "shell", path: ".vagrant-provision.sh", args: "debian_buster"

    # Execute Ansible provisioning
    debian_buster.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.host_vars = {
        "debian_buster" => {
          "hamlib_utils_rot_enabled" => true,
          "hamlib_utils_rot_opts" => "-m 1",
          "satnogs_api_token" => "0123456789abcdef0123456789abcdef01234567",
          "satnogs_rx_device" => "rtlsdr",
          "satnogs_station_elev" => "100",
          "satnogs_station_id" => "99999",
          "satnogs_station_lat" => "10",
          "satnogs_station_lon" => "10",
          "snmpd_enabled" => true,
          "gpsd_enabled" => true
        }
      }
      ansible.groups = {
        "satnogs-setups" => ["debian_buster"],
        "satnogs-radios" => ["debian_buster"],
        "hamlib-utils" => ["debian_buster"],
        "satnogs-clients" => ["debian_buster"],
        "snmpds" => ["debian_buster"],
        "gpsds" => ["debian_buster"]
      }
    end
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

    # Execute shell provisioning script
    debian_bullseye.vm.provision "shell", path: ".vagrant-provision.sh", args: "debian_bullseye"

    # Execute Ansible provisioning
    debian_bullseye.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.host_vars = {
        "debian_bullseye" => {
          "hamlib_utils_rot_enabled" => true,
          "hamlib_utils_rot_opts" => "-m 1",
          "satnogs_api_token" => "0123456789abcdef0123456789abcdef01234567",
          "satnogs_rx_device" => "rtlsdr",
          "satnogs_station_elev" => "100",
          "satnogs_station_id" => "99999",
          "satnogs_station_lat" => "10",
          "satnogs_station_lon" => "10",
          "snmpd_enabled" => true,
          "gpsd_enabled" => true
        }
      }
      ansible.groups = {
        "satnogs-setups" => ["debian_bullseye"],
        "satnogs-radios" => ["debian_bullseye"],
        "hamlib-utils" => ["debian_bullseye"],
        "satnogs-clients" => ["debian_bullseye"],
        "snmpds" => ["debian_bullseye"],
        "gpsds" => ["debian_bullseye"]
      }
    end
  end

end
