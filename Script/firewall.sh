#! /bin/bash
#Accepte le forward de paquet
echo 1 > /proc/sys/net/ipv4/ip_forward

#Accepte tous les paquets d'une connexion déjà établi
iptables -P INPUT DROP
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

#Internet -> DMZ
iptables -t nat -A PREROUTING -i eth0 -p tcp -j DNAT -d 31.33.73.2 --to 192.168.0.2
iptables -t nat -A PREROUTING -i eth0 -p tcp -j DNAT -d 31.33.73.3 --to 192.168.0.3
iptables -t nat -A PREROUTING -i eth0 -p tcp -j DNAT -d 31.33.73.4 --to 192.168.0.4

iptables -A FORWARD -p tcp -d 192.168.0.3 -i eth0 -o eth1 --dport 80 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.3 -i eth0 -o eth1 --dport 443 -m state --state NEW
iptables -A FORWARD -p udp -d 192.168.0.2 -i eth0 -o eth1 --dport 53 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.4 -i eth0 -o eth1 --dport 25 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.4 -i eth0 -o eth1 --dport 22 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.3 -i eth0 -o eth1 --dport 22 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.2 -i eth0 -o eth1 --dport 22 -m state --state NEW

#DMZ -> Internet
iptables -t nat -A POSTROUTING -o eth0 -p tcp -j SNAT -s 192.168.0.2 --to 31.33.73.2
iptables -t nat -A POSTROUTING -o eth0 -p tcp -j SNAT -s 192.168.0.3 --to 31.33.73.3
iptables -t nat -A POSTROUTING -o eth0 -p tcp -j SNAT -s 192.168.0.4 --to 31.33.73.4

iptables -A FORWARD -p tcp -d 192.168.0.3 -i eth1 -o eth0 --dport 80 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.2 -d 200.200.200.200 -i eth1 -o eth0 -m multiport\
       	--dport 80,443 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.3 -d 200.200.200.200 -i eth1 -o eth0 -m multiport\
	--dport 80,443 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.4 -d 200.200.200.200 -i eth1 -o eth0 -m multiport\
       	--dport 80,443 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.6 -d 200.200.200.200 -i eth1 -o eth0 -m multiport \
	--dport 80,443 -m state --state NEW

#DMZ -> LAN
iptables -A FORWARD -p tcp -s 192.168.0.4  -m iprange --dst-range 192.168.0.20-192.168.0.100 -i\
       	eth1 -o eth2 --dport 25 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.4  -m iprange --dst-range 192.168.0.20-192.168.0.100 -i\
       	eth1 -o eth2 --dport 25 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.3 -d 192.168.0.10 -i eth0 -o eth1 --dport 3306 -m state --state NEW

#LAN -> DMZ
iptables -A FORWARD -p tcp -s 192.168.0.4  -m iprange --src-range 192.168.0.20-192.168.0.100 -i\
       	eth2 -o eth1 -m multiport --dport 80,443 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.99 -d 192.168.0.2 -i eth2 -o eth1 --dport 3306 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.99 -d 192.168.0.3 -i eth2 -o eth1 --dport 3306 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.99 -d 192.168.0.4 -i eth2 -o eth1 --dport 3306 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.99 -d 192.168.0.6 -i eth2 -o eth1 --dport 3306 -m state --state NEW

#LAN -> NET
iptables -t nat -A POSTROUTING -o eth0 -p tcp -j SNAT -s 192.168.0.13 --to 31.33.73.6
iptables -t nat -A POSTROUTING -o eth0 -p tcp -j SNAT -s 192.168.0.14 --to 31.33.73.6
iptables -A FORWARD -p tcp -s 192.168.0.13 -i eth2 -o eth0 -m multiport \
	--dport 80,443 -m state --state NEW
iptables -A FORWARD -p tcp -s 192.168.0.14 -d 150.150.150.150 -i eth2 -o eth0 --dport 53 -m state --state NEW
iptables -A FORWARD -p udp -s 192.168.0.14 -d 150.150.150.150 -i eth2 -o eth0 --dport 53 -m state --state NEW

#NET->LAN

iptables -t nat -A PREROUTING -i eth2 -p tcp -j DNAT -d 31.33.73.10 --to 192.168.0.10
iptables -t nat -A PREROUTING -i eth2 -p tcp -j DNAT -d 31.33.73.11 --to 192.168.0.11
iptables -t nat -A PREROUTING -i eth2 -p tcp -j DNAT -d 31.33.73.12 --to 192.168.0.12
iptables -t nat -A PREROUTING -i eth2 -p tcp -j DNAT -d 31.33.73.13 --to 192.168.0.13
iptables -t nat -A PREROUTING -i eth2 -p tcp -j DNAT -d 31.33.73.14 --to 192.168.0.14
iptables -t nat -A PREROUTING -i eth2 -p tcp -j DNAT -d 31.33.73.15 --to 192.168.0.15

iptables -A FORWARD -p tcp -d 192.168.0.10 -i eth2 -o ethO --dport 22 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.10 -i eth2 -o ethO --dport 22 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.10 -i eth2 -o ethO --dport 22 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.10 -i eth2 -o ethO --dport 22 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.14 -i eth2 -o ethO --dport 3389 -m state --state NEW
iptables -A FORWARD -p tcp -d 192.168.0.15 -i eth2 -o ethO --dport 3389 -m state --state NEW
