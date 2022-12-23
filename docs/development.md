# Development Guide

## Setup development environment
1. Install [ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html),
   [vagrant](https://developer.hashicorp.com/vagrant/docs) and
   the [vagrant-libvirt](https://vagrant-libvirt.github.io/vagrant-libvirt/installation.html) plugin.

2. Create the configuration by copying the config folder template:
   ```
   cp -r production.dist production
   ```

3. Edit the configuration at `production/inventory/host_vars/satnogs/main.yml` according tu your needs, e.g.
   add your `satnogs_api_token`

4. Create & provision the guest machine. This step will download a base debian box, and then
   run ansible on the host system to provision the guest machine as SatNOGS Station.
   using the
   ```
   vagrant up
   ```
   Ansible will be running with the following parameters:
   - Playbook directory: `./`
   - Playbook filename: `local.yml`
   - host variables: `production/inventory/host_vars/satnogs/main.yml`

5. Login via ssh.
   ```
   vagrant ssh
   ```

## Common Tasks
- Re-run provisioning.

  To re-run the ansible playbooks (e.g. after some modification), run
  ```
  sudo vagrant provision
  ```

- Run only specific tasks during provisioning.
  To run only specific tasks, add some tag, e.g. `tag: mytag`,
  to those tasks you want to run, then specify these tags in the `Vagrantfile`:
  ```
        ansible.tags = [
          "mytag"
        ]
  ```
  and then re-run provisioning. Ansible will only execute the desired tasks now.

- Create a snapshot: To save the current state of the vm in case you want to restore it later,
  run the following command:

  ```
  sudo vagrant save debian_bullseye "A fresh installation"
  ```

  This could be used to save & later restore a freshly-provisioned SatNOGS station setup,
  reducing the time to get to this state (2022-12-20: Initial provision takes ~15min on kerel's
  development host).

## Common Problems

### Vagrant Network Error
- Problem: `Error while activating network: Call to virNetworkCreate failed`
- Solution: Restart development host after installation of vagrant

### Ansible CallbackModule Error
- Problem:
  ```
  [WARNING]: Failure using method (v2_runner_on_failed) in callback plugin
  'CallbackModule' object has no attribute
  'display_failed_stderr'
  ```
- Solution: Remove `-stdout_callback = unixy` from `ansible.cfg`.
  Upstream Bug: [ansible-collections/community.general#5600](https://github.com/ansible-collections/community.general/issues/5600)

### Ansible finishes with failed tasks but no output log

- Problem: Ansible exited with `failed` tasks, but there is no output log for these tasks.
- Solution: Remove `-stdout_callback = unixy` from `ansible.cfg` for more verbose output.
