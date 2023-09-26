#!/bin/bash
#
# install-git.sh
#
# This script installs Git if it's not already available on the system.

# Check if Git is already installed
if command -v git >/dev/null 2>&1; then
    echo "Git is already installed."
    exit 0
fi

# Check if the user has root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." >&2
   exit 1
fi

# Update package repositories and install Git with automatic yes
echo "Installing Git..."
apt-get -qq update && apt-get -qq install -y git > /dev/null

# Verify that Git was installed successfully
if command -v git >/dev/null 2>&1; then
    echo "Git has been installed."
    exit 0
else
    echo "Failed to install Git." >&2
    exit 1
fi