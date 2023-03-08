#!/bin/bash
#VER2.1
	config_ini=/home/root/.cyberghost/config.ini
	if [ -f "$config_ini" ]; then
	
		# Check if country is set. Default to US
		if ! [ -n "$COUNTRY" ]; then
			echo "Country variable not set. Defaulting to US"
			export COUNTRY="US"
		fi
			
		#Launch and connect to CyberGhost VPN
		sudo cyberghostvpn --connect --country-code $COUNTRY --wireguard $ARGS
		
		# Add CyberGhost nameserver to resolv for DNS
		# Add Nameserver via env variable $NAMESERVER
		if [ -n "$NAMESERVER" ]; then
			echo 'nameserver ' $NAMESERVER > /etc/resolv.conf
		else
			# SMART DNS
			# This will switch baised on country selected
			# https://support.cyberghostvpn.com/hc/en-us/articles/360012002360
			case "$COUNTRY" in
				"NL") echo 'nameserver 75.2.43.210' > /etc/resolv.conf
				;;
				"GB") echo 'nameserver 75.2.79.213' > /etc/resolv.conf
				;;
				"JP") echo 'nameserver 76.223.64.81' > /etc/resolv.conf
				;;
				"DE") echo 'nameserver 13.248.182.241' > /etc/resolv.conf
				;;
				"US") echo 'nameserver 99.83.181.72' > /etc/resolv.conf
				;;
				*) echo 'nameserver 99.83.181.72' > /etc/resolv.conf
				;;
		esac
		fi
	fi
	
