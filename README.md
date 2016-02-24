# AutoInstallPPTP
auto install the PPTP type VPN on Ubuntu 14.04

## install pptpd

## edit /etc/pptpd.conf
localip 192.168.0.1

remote 192.168.0.134-254

## edit chap-secrets
user pptp passwd *

## edit pptpd-optitions
echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options

echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options


## edit sysctl
"net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

$ systcl -p

## edit iptables
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth1 -j MASQUERADE && iptables-save

## edit rc
"iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth1 -j MASQUERADE && iptables-save" >> /etc/init.d/rc.local

## restart pptpd

## pptp 连接VPN 测试流量
$ iptables -t nat -nvL POSTROUTING --line-number
