#!/bin/sh

# TODO: Implement missing options

device_type=`cat /version.txt | grep imagename | cut -d':' -f2 | cut -d'-' -f3`
case "$1" in

	-mo)
		if [ $device_type == "extender" ]; then
			echo "RTROM01-2G-EX"
		else
			echo "RTROM01-2G"
		fi
		;;
	-sn)
		if [ $device_type == "extender" ]; then
			echo "5544332211"
		else
			echo "1122334455"
		fi
		#echo "option $1 is not implemented" ; exit 1  # TODO need to fetch actual serial number
		;;
	-fw)
		echo "rdk-yocto-turris-1"
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-cmac)
		#MAC address of eth1 is used to register device with Plume NOC
		echo $(cat /sys/class/net/eth1/address)
		;;
	-cip)
		if [ $device_type == "extender" ]; then
			echo $(ip addr show br-home | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		else
			echo $(ip addr show brlan0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		fi
		;;
	-cipv6)
		echo ""
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-emac)
		if [ $device_type == "extender" ]; then
			echo $(cat /sys/class/net/br-wan/address)
		else
			echo $(cat /sys/class/net/erouter0/address)
		fi
		;;
	-eip)
		if [ $device_type == "extender" ]; then
			echo $(ip addr show br-wan | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		else
			echo $(ip addr show erouter0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		fi
		;;
	-eipv6)
		echo ""
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-lmac)
		if [ $device_type == "extender" ]; then
			echo $(cat /sys/class/net/br-home/address)
		else
			echo $(cat /sys/class/net/brlan0/address)
		fi
		;;
	-lip)
		if [ $device_type == "extender" ]; then
			echo $(ip addr show br-home | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		else
			echo $(ip addr show brlan0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
		fi
		;;
	-lipv6)
		echo ""
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-ms)
		echo "Full"
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;
	-mu)
		echo "ssl:wildfire.plume.tech:443"
		#echo "option $1 is not implemented" ; exit 1  # TODO
		;;

	*)
		echo "Usage: deviceinfo.sh [-mo|-sn|-fw|-cmac|-cip|-cipv6|-emac|-eip|-eipv6|-lmac|-lip|-lipv6|-ms|-mu]"
		exit 1
		;;
esac
