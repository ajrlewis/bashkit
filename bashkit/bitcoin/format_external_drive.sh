#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <device>"
  exit 1
fi

device=$1

# Check if the device is already mounted
if mountpoint -q "$device"; then
  sudo umount "$device"
fi

# Use parted instead of fdisk for better compatibility
sudo parted "$device" --script rm 1
sudo parted "$device" --script mkpart primary ext4 0% 100%

# Format the device using ext4 file system
sudo mkfs.ext4 "$device"

# Create a directory to mount the formatted device
sudo mkdir -p /media/$USER/bitcoin

# Mount the formatted device to the newly created directory
sudo mount "$device" /media/$USER/bitcoin

echo "External drive formatted and mounted successfully."