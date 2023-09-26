#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the user has root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." >&2
   exit 1
fi

# Update package list and install Tor
sudo apt update
sudo apt install tor -y

# Start Tor service
sudo systemctl start tor.service

# Enable Tor service to start on boot
sudo systemctl enable tor.service
