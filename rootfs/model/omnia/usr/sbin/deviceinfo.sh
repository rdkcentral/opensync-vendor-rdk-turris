#!/bin/sh

# TODO: Implement missing options

case "$1" in

    -mo)
	echo "RTROM01-2G"
#        echo "option $1 is not implemented" ; exit 1  # TODO
        ;;
    -sn)
        echo "1122334455"
#        echo "option $1 is not implemented" ; exit 1  # TODO
        ;;
    -fw)
        #cho "option $1 is not implemented" ; exit 1  # TODO
	echo "rdk-yocto-turris-1"
        ;;
    -cmac)
#        echo "option $1 is not implemented" ; exit 1  # TODO
	echo $(cat /sys/class/net/lan0/address)
        ;;
    -cip)
#        echo "option $1 is not implemented" ; exit 1  # TODO
	echo $(ip addr show lan0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
        ;;
    -cipv6)
#       echo "option $1 is not implemented" ; exit 1  # TODO
	echo ""
        ;;
    -emac)
#        echo "option $1 is not implemented" ; exit 1  # TODO
	echo $(cat /sys/class/net/erouter0/address)
        ;;
    -eip)
#       echo "option $1 is not implemented" ; exit 1  # TODO
	echo $(ip addr show erouter0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
        ;;
    -eipv6)
#       echo "option $1 is not implemented" ; exit 1  # TODO
	echo ""
        ;;
    -lmac)
        #echo "option $1 is not implemented" ; exit 1  # TODO
        echo $(cat /sys/class/net/lan0/address)
        ;;
    -lip)
        #echo "option $1 is not implemented" ; exit 1  # TODO
        echo $(ip addr show lan0 | grep 'inet ' | awk '{print $2}' | cut -f1 -d'/')
        ;;
    -lipv6)
	#      echo "option $1 is not implemented" ; exit 1  # TODO
	echo ""
        ;;
    -ms)
	#echo "option $1 is not implemented" ; exit 1  # TODO
	echo "Full"
        ;;
    -mu)
	echo "ssl:wildfire.plume.tech:443"
#        echo "option $1 is not implemented" ; exit 1  # TODO
        ;;

    *)
        echo "Usage: deviceinfo.sh [-mo|-sn|-fw|-cmac|-cip|-cipv6|-emac|-eip|-eipv6|-lmac|-lip|-lipv6|-ms|-mu]"
        exit 1
        ;;
esac
