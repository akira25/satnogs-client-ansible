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

## Deploying to Docker

There is experimental support to deploy SatNOGS to a Docker container.

The main goal is to either run SatNOGS on your PC without interfering with
existing SDR libraries you probably already have.
It makes it also easier to test and play with SatNOGS.

Footloose is used to handle Docker containers.

* Install footloose (https://github.com/weaveworks/footloose)
* Copy `production.dist` to `production`: `cp -a production.dist production`
* Optionally: Configure `footloose.yaml` and `production/inventory/footloose`
  for multiple SatNOGS containers
* Create and start footloose Docker container(s) with `footloose create`
* Run `footloose ssh "apt-get -q update && apt-get -qy install lsb-release
  python"` to install Ansible dependencies
* Run `ansible-playbook -i production/inventory/footloose site.yml`

If you want to use `satnogs-setup` to configure the container instead of
Ansible variables:

* Run `ansible-playbook -i production/inventory/footloose -t satnogs-setup
  site.yml` to bootstrap SatNOGS instead of running the whole playbook
* Configure your station inside the container with `footloose ssh root@node0
  "satnogs-setup"`
* Enjoy!

Note: Using `satnogs-setup` will provision the container to the latest stable
release of `satnogs-client-ansible` by pulling directly from the Git repository.

To stop the SatNOGS container run `footloose stop` and to start it again run
`footloose start`.
To delete it run `footloose delete`.
Deleting the Docker container will also delete the configuration.

Important: a USB SDR device must be connected before starting the Docker container or it will be recognized but won't work correctly.
If it gets disconnected and reconnected, the Docker container must be stopped and started again for the device to work again.
