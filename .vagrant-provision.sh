#!/bin/sh

case $1 in
	pre)
		case $2 in
			debian_buster)
			;;
			debian_bullseye)
			;;
			debian_bookworm)
			;;
			ubuntu_focal)
			;;
			ubuntu_jammy)
			;;
		esac
		;;
	post)
		case $2 in
			debian_buster)
			;;
			debian_bullseye)
			;;
			debian_bookworm)
			;;
			ubuntu_focal)
			;;
			ubuntu_jammy)
			;;
		esac
		;;
esac
