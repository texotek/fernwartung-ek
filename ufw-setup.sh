#!/bin/bash
sudo apt install ufw -y

sudo ufw allow OpenSSH # Allow SSH to not lose access to machine
sudo ufw allow 51820   # Allow Wireguard connections
sudo ufw allow from 10.0.2.0/24 to any port 3389 # Allow VPN Connection
sudo ufw enable