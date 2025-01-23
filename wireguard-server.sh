apt install -y wireguard
mkdir wireguard
cd wireguard
wg genkey | tee privatekey | wg pubkey > publickey
wg genkey | tee clientPrivatekey | wg pubkey > clientPublickey

ip link add dev wg0 type wireguard
ip link set up dev wg0
ip address add dev wg0 10.0.2.1/24
wg set wg0 private-key ./privatekey listen-port 51820
wg set wg0 peer $(cat clientPublickey) allowed-ips 10.0.2.2/32

clientKey=$(cat ./clientPrivatekey)
publicKey=$(cat ./publickey)
publicIp=$(curl ifconfig.me -4)

printf "[Interface]\nPrivateKey=$clientKey\nAddress=10.0.2.2/24\n[Peer]\nPublicKey=$publicKey\nAllowedIPs=10.0.2.1/32\nEndpoint=$publicIp:51820" > client.conf

