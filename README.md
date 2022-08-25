# SatNOGS client provisioning

Ansible playbook to make the installation procedure for SatNOGS client easier.
How to install:

* Copy `production.dist` to `production`
* Configure `production/inventory/hosts` file
* Configure `production/inventory/host_vars` variables
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

## Testing local changes in Raspbian

If you are running [the Raspbian
image](https://wiki.satnogs.org/Raspberry_Pi_3#Raspbian) and need to
test local changes, follow these steps:

- edit the local cache of the playbooks at /root/.satnogs/ansible
- run the playbooks like so:

```
sudo rm /root/.satnogs/.installed
sudo /usr/local/share/satnogs-setup/setup.sh
```

Any arguments provided to `setup.sh` will be passed on to
ansible-playbook; you can use this to limit which playbooks or tasks
get applied by supplying a `--tags` argument.  For example, to limit
the run to only the satnogs-client playbook, you can run:

```
/usr/local/share/satnogs-setup/setup.sh --tags satnogs-client
```
