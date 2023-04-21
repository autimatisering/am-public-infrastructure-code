#!/bin/sh
# Licensed under the EUPL
# run as root

# update system
echo "upgrading packages"
apt-get update && apt-get dist-upgrade -y

# install docker
echo "installing docker"
wget -O - https://get.docker.com/ | bash -

# install and setup fail2ban
echo "installing fail2ban"
apt-get install fail2ban -y
sed -i "s/#mode   = normal/mode    = aggressive/" /etc/fail2ban/jail.conf
systemctl restart fail2ban.service

# install and setup ufw
echo "installing uwf"
apt-get install ufw -y
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

echo "the script is done"