#!/bin/sh -e
#
# Update udev rules files from remote sources
#
# Copyright (C) 2025 Libre Space Foundation <https://libre.space/>
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

DEFAULT_CONF_FILE=".$(basename "${0%.sh}.conf")"
REQUIREMENTS="
cmp
curl
sed
grep
"
requirements() {
	for req in $REQUIREMENTS; do
		if ! which "$req" >/dev/null; then
			if [ -z "$has_missing" ]; then
				echo "$(basename "$0"): Missing script requirements!" 1>&2
				echo "Please install:" 1>&2
				has_missing=1
			fi
			echo " - '$req'" 1>&2
		fi
	done
	if [ -n "$has_missing" ]; then
		exit 1
	fi
}

usage() {
	cat 1>&2 <<EOF
Usage: $(basename "$0") [OPTIONS]...
Refresh udev rules files from remote sources

Options:
  -c FILE                   Configuration file
                              (default: '$DEFAULT_CONF_FILE')
  -f FILE                   Individual udev rules file to refresh
  -l FILE                   File containing a list with udev rules
                              files to refresh.
  -e SED_EXPRESSION         sed expression to apply to udev rules files
  -n                        Dry run; make no changes to files
  --help                    Print usage

Configuration:
'${conf_file:-$DEFAULT_CONF_FILE}' file is sourced and may contain the following
environment variables:

  REFRESH_UDEV_RULES_SED_EXPRESSION
                            sed expression to apply to udev rules files.
  REFRESH_UDEV_RULES_LIST_FILE
                            File containing a list with udev rules
                              files to refresh.

EOF
	exit 1
}

parse_args() {
	unset conf_file
	unset rules_file
	unset rules_list_file
	unset sed_exp
	unset dry_run

	while [ $# -gt 0 ]; do
		arg="$1"
		case $arg in
			-c)
				if [ -n "$conf_file" ] || [ $# -le 1 ]; then
					usage
				fi
				shift
				conf_file="$1"
				;;
			-f)
				if [ -n "$rules_file" ] || [ $# -le 1 ]; then
					usage
				fi
				shift
				rules_file="$1"
				;;
			-l)
				if [ -n "$rules_list_file" ] || [ $# -le 1 ]; then
					usage
				fi
				shift
				rules_list_file="$1"
				;;
			-e)
				if [ -n "$sed_exp" ] || [ $# -le 1 ]; then
					usage
				fi
				shift
				sed_exp="$1"
				;;
			-n)
				if [ -n "$dry_run" ]; then
					usage
				fi
				dry_run="1"
				;;
			--help)
				usage
				;;
			*)
				usage
				;;
		esac
		shift
	done
}

load_conf() {
	if [ -f "${conf_file:-$DEFAULT_CONF_FILE}" ]; then
		# shellcheck disable=SC1090
		. "$(realpath "${conf_file:-$DEFAULT_CONF_FILE}")"
	fi

	rules_list_file="${rules_list_file:-$REFRESH_UDEV_RULES_LIST_FILE}"
	sed_exp="${sed_exp:-$REFRESH_UDEV_RULES_SED_EXPRESSION}"
}

refresh_file() {
	udev_rules_file="$1"
	sed_exp="$2"

	# Get source URL
	source_url="$(sed -n '1s/^# \+source: \+//p' "$udev_rules_file")"
	if [ -z "$source_url" ]; then
		echo "WARNING: No source location specified in '$udev_rules_file'. Ignoring..." >&2
		return
	fi

	# Get contents of file
	source_content="$(curl -sLf "$source_url")"
	if [ -z "$source_content" ]; then
		echo "ERROR: Could not download '$udev_rules_file' file from source location!" >&2
		exit 1
	fi

	# Apply sed expression
	if [ -n "$sed_exp" ]; then
		source_content="$(echo "$source_content" | sed -Ee "$sed_exp")"
		if [ -z "$source_content" ]; then
			echo "ERROR: sed expression on '$udev_rules_file' creates empty file!" >&2
			exit 1
		fi
	fi

	# Add header comments to content
	source_content="$(cat << EOF
# source: $source_url
#
# Use ./contrib/refresh-udev-rules.sh to refresh this file from remote sources

$source_content
EOF
)"

	if ! echo "$source_content" | cmp -s "$udev_rules_file"; then
		# Create new file
		if [ -z "$dry_run" ]; then
			echo "$source_content" > "$udev_rules_file"
		fi
		echo "'$udev_rules_file' refreshed."
	else
		echo "'$udev_rules_file' no changes."
	fi

}

refresh_list_file() {
	rules_list_file="$1"
	sed_exp="$2"

	(cat "$rules_list_file"; echo) | while read -r rules_list_file_line; do
		if [ -n "$rules_list_file_line" ] && ! echo "$rules_list_file_line" | grep -q "^ *#"; then
			refresh_file "$rules_list_file_line" "$sed_exp"
		fi
	done
}

main() {
	requirements
	parse_args "$@"
	load_conf
	if [ -n "$rules_file" ]; then
		refresh_file "$rules_file" "$sed_exp"
	else
		if [ -n "$rules_list_file" ]; then
			refresh_list_file "$rules_list_file" "$sed_exp"
		fi
	fi
}

main "$@"
