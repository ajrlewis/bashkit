#!/bin/bash
#
# install.sh -d </path/to/installation/directory>
#
# This script installs the latest release version of Bitcoin from GitHub to the specified location.
# It also installs the dependencies needed to build Bitcoin, configures the build process,
# and cleans up the build directory after installation.

set -e # Exit immediately if a command exits with a non-zero status

# Check if the user has root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." >&2
   exit 1
fi

# Define the location where Bitcoin will be installed
install_dir=/usr/local/

# Parse command line options
while getopts ":d:" opt; do
  case $opt in
    d)
      install_dir=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Clone the Bitcoin repository from GitHub
echo "Cloning Bitcoin repository from GitHub..."
if [[ -d "bitcoin" ]]; then
    echo "Bitcoin repository already exists in current path. Trying to update..."
    cd bitcoin && git pull
else
    git clone https://github.com/bitcoin/bitcoin.git
fi

# Move into the Bitcoin source directory
cd bitcoin

# Check out the latest release version
LATEST_VERSION=$(git tag --sort=-v:refname | head -1)
echo "Checking out latest release version: $LATEST_VERSION"
git checkout "$LATEST_VERSION"

# Install the dependencies needed to build Bitcoin
echo "Installing dependencies..."
apt-get update && \
apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libdb5.3++-dev libsqlite3-dev

# Configure the build process
echo "Configuring build process..."
./autogen.sh && ./configure --prefix="$install_dir" --enable-wallet --enable-cxx

# Build and install Bitcoin
echo "Building and installing Bitcoin..."
make -j$(nproc) && \
make install

# Clean up the build directory
echo "Cleaning up..."
cd ..
# rm -rf bitcoin

# Print a message indicating that the installation is complete
echo "Bitcoin has been installed to $install_dir"