#!/bin/sh -e
#
# SatNOGS client setup setup script
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

ANSIBLE_DIR="$HOME/.satnogs/ansible"
BOOTSTRAP_STAMP="$HOME/.satnogs/.bootstrapped"
INSTALL_STAMP="$HOME/.satnogs/.installed"

if [ -f "$BOOTSTRAP_STAMP" ]; then
	cd "$ANSIBLE_DIR" || exit 1
	if [ -s "$INSTALL_STAMP" ]; then
		echo "Applying configuration..."
		tags="$(cat "$INSTALL_STAMP")"
	fi
	if [ ! -f "$INSTALL_STAMP" ]; then
		echo "Updating software and applying configuration. This may take a while..."
		tags="all"
	fi
	if [ -n "$tags" ]; then
		if ansible-playbook "$@" -t "$tags" local.yml; then
			cat /dev/null > "$INSTALL_STAMP"
		fi
		echo "Press enter to continue..."
		# shellcheck disable=SC2034
		read -r _temp
	fi
fi
exec satnogs-setup
