#!/bin/sh

apt-get install pptpd
echo >> /etc/pptpd.conf
echo "localip 192.168.0.1" >> /etc/pptpd.conf
echo "remoteip 192.168.0.234-238,192.168.0.254" >> /etc/pptpd.conf

echo "chap-secrets"
echo >> /etc/ppp/chap-secrets
# set username and password
echo "robin	pptpd	yourpassword	*" >> /etc/ppp/chap-secrets

echo "pptpd-options"
echo >> /etc/ppp/pptpd-options
echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options
echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options

service pptpd restart

echo >> /etc/sysctl.conf
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

sysctl -p

iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth1 -j MASQUERADE && iptables-save

echo >> /etc/init.d/rc.local

echo "iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth1 -j MASQUERADE && iptables-save" >> /etc/init.d/rc.local

service pptpd restart

echo "PPTPD install success！"
