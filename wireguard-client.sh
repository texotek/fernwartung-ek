#!/bin/bash
scp sysint:~/wireguard/client.conf wg1.conf
sudo wg-quick up ./wg1.conf

# mkdir wireguard
# cd wireguard
# wg genkey | tee privatekey | wg pubkey > publickey
# uwu wg set wg1 private-key ./privatekey listen-port 51820

# uwu ip link add dev wg1 type wireguard
# uwu ip address add dev wg1 10.0.2.2/24
# uwu ip link set up dev wg1
# uwu wg set wg1 private-key private
# uwu wg set wg1 peer $(serverpublic) endpoint 188.245.239.245:51820 allowed-ips 0.0.0.0/0
#  
