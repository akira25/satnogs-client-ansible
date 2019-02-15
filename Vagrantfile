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
      ansible.host_vars = {
        "debian" => {
          "hamlib_utils_rot_enabled" => true,
          "hamlib_utils_rot_opts" => "-m 1",
          "satnogs_api_token" => "0123456789abcdef0123456789abcdef01234567",
          "satnogs_rx_device" => "rtlsdr",
          "satnogs_station_elev" => "100",
          "satnogs_station_id" => "99999",
          "satnogs_station_lat" => "10",
          "satnogs_station_lon" => "10",
          "snmpd_enabled" => true
        }
      }
      ansible.groups = {
        "satnogs-setups" => ["debian"],
        "satnogs-radios" => ["debian"],
        "hamlib-utils" => ["debian"],
        "satnogs-clients" => ["debian"],
        "snmpds" => ["debian"],
        "gpsds" => ["debian"]
      }
    end
  end

end
