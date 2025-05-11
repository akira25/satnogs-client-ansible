# SatNOGS client provisioning

Ansible playbook to make the installation procedure for SatNOGS client easier.
How to install:

* Copy `production.dist` to `production`
* Configure `production/inventory/hosts` file
* Configure `production/inventory/host_vars/satnogs` variables
* Run `ansible-playbook -i production/inventory/hosts site.yml`
* Enjoy!

## Purpose of this fork

I strongly disagree on running docker on a raspberrypi to be a good idea. Thus,
I reverted most changes into that direction in this repo. Instead, satnogs-client
gets installed plain.

## Supported distributions and releases

This Ansible playbook supports the following distributions and releases:

* Raspberry Pi OS
  * Buster (currently broken!)
  * Bullseye
  * Bookworm
* Debian
  * Buster (currently broken!)
  * Bullseye
  * Bookworm
* Ubuntu
  * Focal
  * Jammy
  * Noble

## Required Ansible version

The minimum required Ansible version is version 2.16.
Follow the [installation guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
to install the required Ansible version.
