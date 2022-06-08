#!/bin/sh

case $1 in
	pre)
		case $2 in
			debian_buster)
			;;
			debian_bullseye)
			;;
		esac
		;;
	post)
		case $2 in
			debian_buster)
			;;
			debian_bullseye)
			;;
		esac
		;;
esac
