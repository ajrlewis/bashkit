#!/bin/bash

mkdir "$HOME/.bitcoin"

# Define the location and name of the bitcoin configuration file
bitcoin_conf="$HOME/.bitcoin/bitcoin.conf"

# Check if the bitcoin configuration file already exists
if [ -f "$bitcoin_conf" ]; then
    echo "Bitcoin configuration file already exists at $bitcoin_conf"
    exit 1
fi

# Use Tor for network connections
proxy=127.0.0.1:9050

# Set the rpcuser value
rpcuser=nakamoto

# Generate a random rpcpassword value
rpcpassword=$(openssl rand -hex 32)

# Define the rpcport and listen address
rpcport=8332
listen_address="127.0.0.1"

# Use external hard drive to store blockchain.
datadir=/media/$USER/bitcoin

# Write the bitcoin configuration file
cat <<EOF > "$bitcoin_conf"
proxy=$proxy 
rpcuser=$rpcuser
rpcpassword=$rpcpassword
rpcport=$rpcport
rpcallowip=$listen_address
rpcbind=$listen_address
datadir=$datadir
EOF

# Set the correct file permissions for the bitcoin configuration file  ensures that only the owner can read and modify the bitcoin configuration file.
chmod 600 "$bitcoin_conf"