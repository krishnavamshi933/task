#!/bin/bash
apt update
apt upgrade -y
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd
apt install fail2ban -y
apt install rsyslog -y
systemctl enable rsyslog
