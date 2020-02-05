#!/bin/sh -e
#
# SatNOGS client setup configuration script
#
# Copyright (C) 2017-2020 Libre Space Foundation <https://libre.space/>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

. /etc/default/satnogs-setup

SATNOGS_CONFIG_CONFIG_FILE="$SATNOGS_SETUP_SATNOGS_CONFIG_CONFIG_FILE"
SATNOGS_CONFIG_ANSIBLE_URL="$SATNOGS_SETUP_ANSIBLE_URL"
SATNOGS_CONFIG_ANSIBLE_BRANCH="$SATNOGS_SETUP_ANSIBLE_BRANCH"

export SATNOGS_CONFIG_CONFIG_FILE
export SATNOGS_CONFIG_ANSIBLE_URL
export SATNOGS_CONFIG_ANSIBLE_BRANCH

"$SATNOGS_SETUP_SATNOGS_CONFIG"
