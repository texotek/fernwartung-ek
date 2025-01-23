# fernwartung-ek

## Usage


## VPN Setup

Der Server soll hinter einem Wireguard VPN sein. Die Dokumentationen dazu sind verfügbar auf [3] und [4] \(inoffiziell).

Die folgenden Befehle werden am Server ausgeführt:

```bash
# wireguard installieren
apt install -y wireguard

# keys erstellen
mkdir wireguard
cd wireguard
wg genkey | tee privatekey | wg pubkey > publickey
wg genkey | tee clientPrivatekey | wg pubkey > clientPublickey

# wireguard interface am server einrichten
ip link add dev wg0 type wireguard
ip link set up dev wg0
ip address add dev wg0 10.0.2.1/24
wg set wg0 private-key ./privatekey listen-port 51820
wg set wg0 peer $(cat clientPublickey) allowed-ips 10.0.2.2/32


# client config datei erstellen
clientKey=$(cat ./clientPrivatekey)
publicKey=$(cat ./publickey)
publicIp=$(curl ifconfig.me -4)

printf "[Interface]\nPrivateKey=$clientKey\nAddress=10.0.2.2/24\n[Peer]\nPublicKey=$publicKey\nAllowedIPs=10.0.2.1/32\nEndpoint=$publicIp:51820" > client.conf
```

Damit wird ein Wireguard Interface am Server gestartet und konfiguriert, und eine Konfigurationsdatei für den Client erstellt.

Am Client wird die Datei dann noch mit `scp sysint:~/wireguard/client.conf wg1.conf` heruntergeladen und mit `sudo wg-quick up ./wg1.conf`
gestartet.

## UFW Setup
 
Damit der xrdp service nur über VPN accessible ist, richte ich eine Firewall ein. Diese Firewall ist ufw.

```bash
sudo apt update && sudo apt upgrade
sudo apt install ufw
```

```bash
sudo ufw allow OpenSSH # Allow SSH to not lose access to machine
sudo ufw allow 51820   # Allow Wireguard connections

sudo ufw allow from 10.0.2.0/24 to any port 3389 # Allow VPN Connection
sudo ufw enable
```


[1]

## Xfce + Xrdp Setup
In diesem Beispiel verwende ich dieses Tutorial [2].

```bash
sudo apt update && sudo apt upgrade
```
Installation von xfce:

```bash
sudo apt install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils -y
```

## xrdp Installation & Setup
Installation von xrdp
```bash
sudo apt install xrdp -y
sudo systemctl status xrdp
```

```bash
sudo adduser xrdp ssl-cert
```

Nun konfigurieren wir, dass xfce4-session als Sitzungsmanager bei grafischer Anmeldeanforderung verwendet wird. Wenn Sie diese Informationen nicht in die .xsession-Datei schreiben, wird kein Sitzungsmanager ausgewählt und die RDP-Sitzung kann keine Verbindung zur grafischen Anzeige herstellen.

```bash
echo "startxfce4" | tee .xsession
```


# Quellen

[1] - https://www.digitalocean.com/community/tutorials/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04

[2] - https://www.vps-mart.com/blog/install-xfce-and-xrdp-service-on-remote-ubuntu

[3] - https://www.wireguard.com/quickstart/

[4] - https://github.com/pirate/wireguard-docs
