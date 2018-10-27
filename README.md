# SatNOGS client provisioning

Ansible playbook to make the installation procedure for SatNOGS client easier.
How to install:

* Copy `production.dist` to `production`
* Configure `production/inventory/hosts` file
* Configure `production/inventory/host_vars` variables
* Run `ansible-playbook -i production/inventory site.yml`
* Enjoy!

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

## gr-satnogs release process

1. Tag version in [gr-satnogs](https://gitlab.com/librespacefoundation/satnogs/gr-satnogs/)
2. Update changelog in [gr-satnogs-package](https://gitlab.com/librespacefoundation/satnogs/gr-satnogs-package), which triggers a new gr-satnogs package build
3. Update `satnogs_radio_gr_satnogs_package` variable in [role satnogs-radio defaults](roles/satnogs-radio/defaults/main.yml)
