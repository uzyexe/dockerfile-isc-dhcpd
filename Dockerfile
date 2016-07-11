FROM alpine:3.4

RUN apk add --update dhcp && \
    touch /var/lib/dhcp/dhcpd.leases
ADD dhcpd.sh /dhcpd
ADD dhcpd.conf /etc/dhcpd.conf.example

EXPOSE 67
EXPOSE 67/udp
EXPOSE 547
EXPOSE 547/udp
EXPOSE 647
EXPOSE 647/udp
EXPOSE 847
EXPOSE 847/udp

ENTRYPOINT ["/dhcpd"]
CMD ["-f", "-cf", "/etc/dhcpd.conf", "-lf", "/var/lib/dhcp/dhcpd.leases", "--no-pid"]
