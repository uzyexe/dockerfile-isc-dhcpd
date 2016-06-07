#!/bin/sh

if [ ! -f /etc/dhcpd.conf ]; then
    IP=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
    PAIR=$(netmask -s $IP | awk '{print $1}')
    NETWORK=$(echo $PAIR | cut -d/ -f1)
    NETMASK=$(echo $PAIR | cut -d/ -f2)
    cp /default_dhcpd.conf /etc/dhcpd.conf
    echo "subnet $NETWORK netmask $NETMASK { }" >> /etc/dhcpd.conf
fi

exec /usr/sbin/dhcpd $@
