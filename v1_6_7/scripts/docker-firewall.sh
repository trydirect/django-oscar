#!/bin/sh
echo "Checking for existing $CHAIN_NAME chain..."

iptables -S DOCKER-FIREWALL
if [ 0 -ne $? ];
then
    echo "No existing chain. Create new."
    iptables -N DOCKER-FIREWALL
fi

iptables -S DOCKER-USER
if [ 0 -ne $? ];
then
    echo "No existing chain. Create new."
    iptables -N DOCKER-USER
fi

iptables -D FORWARD -j DOCKER-USER

echo "Flushing and filling rule to only accept port $ACCEPT_PORT to the chain..."
iptables -F DOCKER-FIREWALL
iptables -F DOCKER-USER
iptables -I FORWARD -j DOCKER-USER
iptables -A DOCKER-FIREWALL -m state --state RELATED,ESTABLISHED -j RETURN
iptables -A DOCKER-FIREWALL -m state --state INVALID -j DROP

iptables -A DOCKER-FIREWALL -p tcp -m tcp  -m state --state  NEW -m multiport --dports {{ports}} -j RETURN
#iptables -A DOCKER-FIREWALL -s 192.168.0.104/32  -p tcp -m tcp  -m state --state  NEW --dport 8080 -j RETURN
iptables -A DOCKER-FIREWALL -j DROP

# Print rule for confirmation
iptables -S DOCKER-FIREWALL

echo "Checking whether the  DOCKER-FIREWALL chain enforced to the entrance network interface..."

iptables -S DOCKER-USER | grep DOCKER-FIREWALL
if [ 0 -ne $? ];
then
    EXTDEV=`ip route show | grep default | awk '{print $5;}'`
    echo "Currently not enforced. Enforcing the chain to $EXTDEV interface."
    iptables -I DOCKER-USER -i $EXTDEV -j DOCKER-FIREWALL
    iptables -A DOCKER-USER -j RETURN
    # print rule for confirmation
    iptables -S DOCKER-USER | grep DOCKER-FIREWALL
fi

