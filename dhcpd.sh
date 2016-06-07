#!/bin/sh

if [ ! -f /etc/dhcpd.conf ]; then
    IPADDR=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}')
    NETWORK=$(ipcalc -n $IPADDR | cut -d"=" -f2)
    NETMASK=$(ipcalc -m $IPADDR | cut -d"=" -f2)
    cp /etc/dhcpd.conf.example /etc/dhcpd.conf
    echo "subnet $NETWORK netmask $NETMASK { }" >> /etc/dhcpd.conf
fi

exec /usr/sbin/dhcpd $@
