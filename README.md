# fernwartung-ek

## Usage


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