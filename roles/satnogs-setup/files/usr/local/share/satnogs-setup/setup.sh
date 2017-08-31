#!/bin/sh

. /etc/default/satnogs-setup

ansible-pull -U "$SATNOGS_SETUP_ANSIBLE_URL"
