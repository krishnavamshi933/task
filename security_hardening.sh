#!/bin/bash

# Update system packages
sudo apt update
sudo apt upgrade -y

# Disable root login
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo service ssh restart

# Enable firewall and allow necessary services
sudo ufw enable
sudo ufw allow OpenSSH
sudo ufw allow 80  # Allow HTTP traffic
sudo ufw allow 443  # Allow HTTPS traffic
sudo ufw reload

# Install and configure fail2ban
sudo apt install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
