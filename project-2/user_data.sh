#!/bin/bash
# Simple Apache setup and HTML injection

# Update and install Apache
apt-get update -y
apt-get install -y apache2

# Ensure the web root exists
mkdir -p /var/www/html

# Enable and start Apache
systemctl enable apache2
systemctl start apache2

# Wait a few seconds to ensure Apache setup completes
sleep 3

# Write HTML page with instance hostname
HOSTNAME=$(hostname)
echo "<h1>Hello from Web Server 1 - $HOSTNAME</h1>" | tee /var/www/html/index.html


