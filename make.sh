#!/bin/bash

display_usage() {
	echo "Wrong parameters"
	echo -e "Usage: $0 install \n $0 uninstall \n $0 purge"
} 

case "$#" in
	"1")
		case "$1" in
			"install") 
				sudo cp -r batleth /etc
				echo "Do you want to run it after starting the system? (Y/N): "
				read r
				if [[ "$r" = Y || "$r" = y ]]
					then 
						cp files/batleth.desktop ~/.config/autostart
				fi
				sudo cp files/batleth /etc/init.d
				cd /etc/
				sudo chmod -R 777 batleth
				cd batleth 
				mix deps.get
				sudo mkdir /var/log/batleth  
				sudo chmod 667 /var/log/batleth 
				mix install 
				mix compile 
				;;
			"uninstall")
				mix uninstall &> /dev/null
				;;
			"purge")
				mix uninstall &> /dev/null
				sudo rm -rf /var/log/batleth &> /dev/null;;
				
			*) display_usage
		esac;;
	*) display_usage
esac
