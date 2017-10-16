#!/bin/sh
#
# SatNOGS client setup configuration script
#
# Copyright (C) 2017 Libre Space Foundation <https://libre.space/>
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

BACKTITLE="SatNOGS client configuration | Currently installed: gr-satnogs-$(dpkg-query --show -f='${Version}' gr-satnogs), satnogs-client-$(/var/lib/satnogs/bin/pip show satnogsclient | awk '/^Version: / { print $2 }')"
WIDTH="78"
YAMLFILE_PATH="${1:-/etc/ansible/host_vars/localhost}"
BOOTSTRAP_STAMP="$HOME/.satnogs/.bootstrapped"
INSTALL_STAMP="$HOME/.satnogs/.installed"

MAIN_MENU="Basic:Basic configuration options:menu
Advanced:Advanced configuration options:menu
Show:Show configuration file:show
Update:Update satnogs-setup:update
Reset:Reset configuration:reset
About:Information about satnogs-setup:about"

BASIC_MENU="SATNOGS_API_TOKEN:Define API token:input
SATNOGS_NETWORK_API_URL:Define network API URL:input
SATNOGS_RX_DEVICE:Define RX device:input
SATNOGS_STATION_ELEV:Define station elevation:input
SATNOGS_STATION_ID:Define station ID:input
SATNOGS_STATION_LAT:Define station latitude:input
SATNOGS_STATION_LON:Define station longitude:input
HAMLIB_UTILS_ROT_ENABLED:Enable Hamlib rotctld:yesno
HAMLIB_UTILS_ROT_OPTS:Define Hamlib rotctld options:input"

ADVANCED_MENU="$BASIC_MENU
SATNOGS_PRE_OBSERVATION_SCRIPT:Define pre-observation script:input
SATNOGS_POST_OBSERVATION_SCRIPT:Define post-observation script:input
SATNOGS_APP_PATH:Define application data path:input
SATNOGS_OUTPUT_PATH:Define output data path:input
SATNOGS_COMPLETE_OUTPUT_PATH:Define completed data path:input
SATNOGS_INCOMPLETE_OUTPUT_PATH:Define incompleted data path:input
SATNOGS_REMOVE_RAW_FILES:Remove raw files:yesno
SATNOGS_VERIFY_SSL:Verify SatNOGS network SSL certificate:yesno
SATNOGS_SQLITE_URL:Define SQLite URI:input
SATNOGS_ROT_IP:Define Hamlib rotctld IP:input
SATNOGS_ROT_PORT:Define Hamlib rotctld port:input
SATNOGS_RIG_IP:Define Hamlib rigctld IP:input
SATNOGS_RIG_PORT:Define Hamlib rigctld port:input
SATNOGS_ROT_THRESHOLD:Define Hamlib rotctld command threshold:input
SATNOGS_DOPPLER_CORR_PER_SEC:Define rate of doppler correction (sec):input
SATNOGS_LO_OFFSET:Define local oscillator offset:input
SATNOGS_PPM_ERROR:Define PPM error:input
SATNOGS_IF_GAIN:Define SatNOGS Radio IF Gain:input
SATNOGS_RF_GAIN:Define SatNOGS Radio RF Gain:input
SATNOGS_BB_GAIN:Define SatNOGS Radio BB Gain:input
SATNOGS_ANTENNA:Define SatNOGS Radio Antenna:input
SATNOGS_DEV_ARGS:Define SatNOGS Radio dev arguments:input
ENABLE_IQ_DUMP:Enable IQ dump:yesno
IQ_DUMP_FILENAME:Define IQ dump filename:input
DISABLE_DECODED_DATA:Disable decoded data:yesno
SATNOGS_RADIO_GR_SATNOGS_PACKAGE:Define gr-satnogs package:input
HAMLIB_UTILS_RIG_ENABLED:Enable Hamlib rigctld:yesno
HAMLIB_UTILS_RIG_OPTS:Define Hamlib rigctld options:input
SATNOGS_CLIENT_VERSION:Define SatNOGS client version:input
SATNOGS_CLIENT_URL:Define SatNOGS client Git URL:input
SATNOGS_SETUP_ANSIBLE_URL:Define Ansible Git URL:input"

to_lower() {
	tr '[:upper:]' '[:lower:]'
}

to_upper() {
	tr '[:lower:]' '[:upper:]'
}

get_tags_items_list() {
	local menu="$1"
	local variables

	echo "$menu" | awk 'BEGIN { FS=":" } { printf("\"%s\" \"%s\" ", $1, $2) }'
}

get_item() {
	local menu="$1"
	local tag="$2"

	echo "$(get_menu "$1" | awk 'BEGIN { FS=":" } /'"$tag"'/ { print $2 }')"
}

get_type() {
	local menu="$1"
	local tag="$2"

	echo "$(get_menu "$1" | awk 'BEGIN { FS=":" } /'"$tag"'/ { print $3 }')"
}

get_menu() {
	local menu="$1"

	eval "echo \"\$$(echo "$menu" | to_upper)_MENU\""
}

get_variable() {
	local file="$1"
	local variable="$2"

	if [ -f "$file" ]; then
		awk 'BEGIN { FS="'"$variable"' *: *" } /^'"$variable"' *:/ { print $2 }' "$file"
	fi
}

set_variable() {
	local file="$1"
	local variable="$2"
	local value="$3"

	if [ -f "$file" ]; then
		sed -i '/^'"$variable"' *:.*/ d' "$file"
	fi
	if [ -n "$value" ]; then
		echo "${variable}: ${value}" >> "$file"
		sort -o "$file" "$file"
	fi
}

menu() {
	local title="$1"
	local menu="$2"
	local default="$3"
	local cancel="$4"
	local res

	eval "whiptail \
		--clear \
		--backtitle \"$BACKTITLE\" \
		--title \"$title\" \
		--ok-button \"Ok\" \
		--cancel-button \"$cancel\" \
		--default-item \"$default\" \
		--menu \"[UP], [DOWN] arrow keys to move\n[ENTER] to select\" 0 0 0 \
		$(get_tags_items_list "$menu")"
	res=$?
	if [ $res -eq 1 ] || [ $res -eq 255 ]; then
		echo "Back" 1>&2
	fi
}

input() {
	local inputbox="$1"
	local init="$2"
	local res

	whiptail \
		--clear \
		--backtitle "$BACKTITLE" \
		--title "Parameter definition" \
		--ok-button "Ok" \
		--cancel-button "Cancel" \
		--inputbox "$inputbox" 0 "$WIDTH" -- "$2"
	res=$?
	if [ $res -eq 1 ] || [ $res -eq 255 ]; then
		echo "Cancel" 1>&2
	fi
}

yesno() {
	local yesno="$1"
	local res

	whiptail \
		--clear \
		--backtitle "$BACKTITLE" \
		--title "Parameter definition" \
		--yes-button "Yes" \
		--no-button "No" \
		--yesno "$yesno" 0 0

	res=$?
	if [ $res -eq 1 ] || [ $res -eq 255 ]; then
		echo "False" 1>&2
	else
		echo "True" 1>&2
	fi
}

exec 3>&1

tag="Main"
while true; do

	case $tag in
		Back)
			if [ "$menu" = "Main" ]; then
				break
				exec 3>&-
			fi
			tag="Main"
			;;
		Show)
			if [ -f "$YAMLFILE_PATH" ]; then
				whiptail \
					--clear \
					--backtitle "$BACKTITLE" \
					--title "SatNOGS client configuration" \
					--ok-button "Ok" \
					--textbox "$YAMLFILE_PATH" 0 0
			fi
			tag="Main"
			;;
		Basic|Advanced)
			menu="$tag"
			tag="$(eval "menu \"$tag Menu\" \"\$$(echo "$tag" | to_upper)_MENU\" \"$item\" \"Back\" 2>&1 1>&3")"
			item=""
			;;
		Main)
			menu="$tag"
			tag="$(eval "menu \"Main Menu\" \"\$MAIN_MENU\" \"$item\" \"Finish\" 2>&1 1>&3")"
			item=""
			;;
		Update)
			rm -f "$BOOTSTRAP_STAMP" "$INSTALL_STAMP"
			exec satnogs-setup
			;;
		Reset)
			rm -f "$BOOTSTRAP_STAMP" "$INSTALL_STAMP" "$YAMLFILE_PATH"
			exec satnogs-setup
			;;
		About)
			whiptail \
				--clear \
				--backtitle "$BACKTITLE" \
				--title "SatNOGS client configuration" \
				--ok-button "Ok" \
				--msgbox "satnogs-setup is a tool for configuring SatNOGS client system" 0 0
			tag="Main"
			;;
		*)
			type="$(get_type "$menu" "$tag")"
			item="$(get_item "$menu" "$tag")"
			variable="$(echo "$tag" | to_lower)"
			init="$(get_variable "$YAMLFILE_PATH" "$variable")"
			input="$(eval "$type \"$item\" \"$init\" 2>&1 1>&3")"
			if [ "$input" != "Cancel" ]; then
				set_variable "$YAMLFILE_PATH" "$variable" "$input"
			fi
			item="$tag"
			tag="$menu"
			;;
	esac

done

exec 3>&-
