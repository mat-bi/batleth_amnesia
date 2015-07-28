#!/bin/bash

display_usage() {
	echo "Wrong parameters"
	echo -e "Usage: $0 install \n $0 uninstall \n $0 purge"
} 

case "$#" in
	"1")
		case "$1" in
			"install") 
				sudo cp batleth /etc
				cd /etc/
				sudo chmod -R 777 batleth
				cd batleth 
				mix deps.get
				sudo mkdir /var/log/batleth  
				sudo chmod 667 /var/log/batleth 
				mix install 
				mix compile 
				echo "Do you want to run it after starting the system? (Y/N): "
				read r
				if [[ "$r" = Y || "$r" = y ]]
					then 
						cp batleth.desktop ~/.config/autostart
				fi
				;;
			"uninstall")
				mix uninstall &> /dev/null
				;;
			"purge")
				mix uninstall &> /dev/null
				sudo rm -rf /var/log/batleth &> /dev/null;;
			"kill") kill -9 `cat pid.txt`;;
				
			*) display_usage
		esac;;
	*) display_usage
		echo "*" >> /home/mat-bi/b.txt
esac
