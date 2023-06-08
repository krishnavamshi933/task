#!/bin/bash

# Install necessary packages
sudo apt update
sudo apt install python3 python3-pip python3-venv postgresql postgresql-contrib nginx -y

# Create a virtual environment
python3 -m venv myenv
source myenv/bin/activate

# Install Django and dependencies
sudo -H myenv/bin/pip install django gunicorn

# Set up Postgres database
sudo -u postgres psql -c "CREATE DATABASE mydatabase;"
sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"
sudo -u postgres psql -c "ALTER ROLE myuser SET client_encoding TO 'utf8';"
sudo -u postgres psql -c "ALTER ROLE myuser SET default_transaction_isolation TO 'read committed';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;"

# Configure Django settings
echo "DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mydatabase',
        'USER': 'myuser',
        'PASSWORD': 'mypassword',
        'HOST': 'localhost',
        'PORT': '',
    }
}" > myproject/settings.py

# Set up Gunicorn
echo "[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=root
Group=www-data
WorkingDirectory=/path/to/myproject
ExecStart=/path/to/myenv/bin/gunicorn --access-logfile - --workers 3 --bind unix:/path/to/myproject.sock myproject.wsgi:application

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/gunicorn.service

# Set up Nginx
echo "server {
    listen 80;
    server_name mydomain.com;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /path/to/myproject;
    }

    location / {
        include proxy_params;
        proxy_pass http://unix:/path/to/myproject.sock;
    }
}" | sudo tee /etc/nginx/sites-available/myproject

sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
sudo systemctl restart nginx
