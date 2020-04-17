#!/bin/sh

#If not stated otherwise in this file or this component's LICENSE
#file the following copyright and licenses apply:
#
#Copyright [2019] [RDK Management]
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

[ -z "$1" ] && echo "Error: should be run by udhcpc" && exit 1

OPTS_FILE=/var/run/udhcpc_$interface.opts

set_classless_routes() {
	local max=128
	local type
	while [ -n "$1" -a -n "$2" -a $max -gt 0 ]; do
		[ ${1##*/} -eq 32 ] && type=host || type=net
		echo "udhcpc: adding route for $type $1 via $2"
		route add -$type "$1" gw "$2" dev "$interface"
		max=$(($max-1))
		shift 2
	done
}

print_opts()
{
    [ -n "$router" ]    && echo "gateway=$router"
    [ -n "$timesrv" ]   && echo "timesrv=$timesrv"
    [ -n "$namesrv" ]   && echo "namesrv=$namesrv"
    [ -n "$dns" ]       && echo "dns=$dns"
    [ -n "$logsrv" ]    && echo "logsrv=$logsrv"
    [ -n "$cookiesrv" ] && echo "cookiesrv=$cookiesrv"
    [ -n "$lprsrv" ]    && echo "lprsrv=$lprsrv"
    [ -n "$hostname" ]  && echo "hostname=$hostname"
    [ -n "$domain" ]    && echo "domain=$domain"
    [ -n "$swapsrv" ]   && echo "swapsrv=$swapsrv"
    [ -n "$ntpsrv" ]    && echo "ntpsrv=$ntpsrv"
    [ -n "$lease" ]     && echo "lease=$lease"
    # vendorspec may contain all sorts of binary characters, convert it to base64
    [ -n "$vendorspec" ] && echo "vendorspec=$(echo $vendorspec | base64)"
}

setup_interface() {
	echo "udhcpc: ifconfig $interface $ip netmask ${subnet:-255.255.255.0} broadcast ${broadcast:-+}"
	ifconfig $interface $ip netmask ${subnet:-255.255.255.0} broadcast ${broadcast:-+}

	[ -n "$router" ] && [ "$router" != "0.0.0.0" ] && [ "$router" != "255.255.255.255" ] && {
		echo "udhcpc: setting default routers: $router"

		local valid_gw=""
		for i in $router ; do
			route add default gw $i dev $interface
			valid_gw="${valid_gw:+$valid_gw|}$i"
		done
		eval $(route -n | awk '
			/^0.0.0.0         ('$valid_gw')\W/ {next}
			/^0.0.0.0/ {print "route del -net "$1" gw "$2";"}
		')
	}
	# CIDR STATIC ROUTES (rfc3442)
	[ -n "$staticroutes" ] && set_classless_routes $staticroutes
	[ -n "$msstaticroutes" ] && set_classless_routes $msstaticroutes

    #Fill resolv.conf file
    [ -n "$dns" ]  && {
           echo "nameserver $dns" > /etc/resolv.conf
    }
    #
    # Save the options list
    #
    print_opts > $OPTS_FILE
}

applied=
case "$1" in
	deconfig)
		ifconfig "$interface" 0.0.0.0
        rm -f "$OPTS_FILE"
	;;
	renew)
		setup_interface update
	;;
	bound)
		setup_interface ifup
	;;
esac

# custom scripts
for x in /usr/plume/scripts/udhcpc.d/[0-9]*
do
	[ ! -x "$x" ] && continue
	# Execute custom scripts
	"$x" "$1"
done

# user rules
[ -f /etc/udhcpc.user ] && . /etc/udhcpc.user

exit 0
