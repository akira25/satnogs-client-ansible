# SatNOGS client provisioning

Ansible playbook to make the installation procedure for SatNOGS client easier.
How to install:

* Copy `production.dist` to `production`
* Configure `production/inventory/hosts` file
* Configure `production/inventory/host_vars/satnogs` variables
* Run `ansible-playbook -i production/inventory/hosts site.yml`
* Enjoy!

## Supported distributions and releases

This Ansible playbook supports the following distributions and releases:

* Raspbian
  * Buster
* Debian
  * Buster
  * Bullseye

## Required Ansible version

The minimum required ansible is version 2.12. This is not available in Debian Bullseye, but
can be installed using the Ubuntu PPA. Follow the
[Installing Ansible on Debian](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian)
guide to get the required ansible.
