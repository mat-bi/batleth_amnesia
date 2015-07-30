#!/bin/bash

display_usage() {
	echo "Wrong parameters"
	echo -e "Usage: $0 install \n $0 uninstall \n $0 purge"
} 


if [ `cat /etc/lsb-release | grep ^DISTRIB_ID | sed "s/^DISTRIB_ID=//"` = Ubuntu ]
then
	z=0
else
	z=1
fi

if [ `whoami` != root ]
then
	echo "Program must be run by a root!"
	exit $?
fi

case "$#" in
	"1")
		case "$1" in
			"install") 
				if [ $z = 0 ]
				then
					cp files/batleth /etc/init.d
					chmod 777 /etc/init.d/batleth
				else
					cp files/batleth.service /etc/systemd/
				fi
				cp -r batleth /etc
				echo "Do you want to run it after starting the system? (Y/N): "
				read r
				if [[ "$r" = Y || "$r" = y ]]
					then 
						cp files/batleth.desktop /etc/xdg/autostart
				fi
				cd /etc/
				chmod -R 777 batleth
				cd batleth 
				mix deps.get
				mkdir /var/log/batleth  
				chmod 667 /var/log/batleth
				
				mix compile
				mix install  
				;;
			"uninstall")
				cd /etc/batleth
				mix uninstall &> /dev/null
				/etc/init.d/batleth stop &> /dev/null
				cd ..
				rm -rf batleth
				if [ $z = 0 ]
				then
					rm /etc/init.d/batleth
				else
					rm /etc/systemd/batleth.service
				fi
				;;
			"purge")
				$0 uninstall
				sudo rm -rf /var/log/batleth &> /dev/null;;
				
			*) display_usage
		esac;;
	*) display_usage
esac
