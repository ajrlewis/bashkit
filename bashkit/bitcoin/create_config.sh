#!/bin/bash

# Define the location and name of the bitcoin configuration file
bitcoin_conf="$HOME/.bitcoin/bitcoin.conf"

# Check if the bitcoin configuration file already exists
if [ -f "$bitcoin_conf" ]; then
    echo "Bitcoin configuration file already exists at $bitcoin_conf"
    exit 1
fi

# Use Tor for network connections
proxy=127.0.0.1:9050

# Choose a random rpcuser value from the list
# List of well-known bitcoin people for rpcuser values
# Generate a random rpcpassword value
people=("nakamoto" "szabo" "ver" "andresen" "garzik" "antonopoulos" "song" "wong" "rogerkver" "charlielee")
rpcuser=${people[$RANDOM % ${#people[@]}]}
rpcpassword=$(openssl rand -hex 32)

# Define the rpcport and listen address
rpcport=8332
listen_address="127.0.0.1"

# Use external hard drive to store blockchain.
data_dir=$(bash /path/to/script.sh)

# Set the maximum number of inbound and outbound connections
max_connections=125

# Set the size of the database cache in megabytes
db_cache=2048

# Set the target size for the transaction memory pool in megabytes
mempool_size=300

# Set the maximum size of a block in bytes
max_block_size=2000000

# Set the maximum size of a transaction in bytes
max_tx_size=100000

# Set the minimum transaction fee in satoshis per kilobyte
min_tx_fee=1000

# Set the maximum number of orphan transactions to keep in memory
max_orphan_txs=1000

# Set the maximum number of headers to download at once
max_headers=2000

# Set the number of blocks to keep in memory for compact block filtering
cbf_memory=1000

# Set the number of blocks for which to keep orphan transactions in memory
orphan_tx_keep_alive=2

# Set the maximum number of seconds to keep a block in the compact block cache
cb_cache_time=60

# Set the maximum number of peers to which to send a compact block
cb_send_targets=10

# Set the maximum number of outbound peers
max_outbound_peers=8

# Set the maximum number of inbound peers
max_inbound_peers=125

# Set the maximum number of automatic connections
max_add_node_connections=16

# Set the number of blocks between attempts to automatically add nodes
add_node_period=86400

# Set the target number of seconds between blocks
target_block_time=600

# Set the maximum number of seconds that a block timestamp can be ahead of the current time
max_future_block_time=$((2 * target_block_time))

# Set the maximum number of seconds that a block timestamp can be behind the current time
max_old_block_time=$((target_block_time / 2))

# Set the maximum number of blocks to keep in the block file cache
block_file_cache_size=64

# Set the maximum number of megabytes to use for block file caching
block_file_cache_size_mb=500

# Set the maximum number of orphan transactions to request from a peer
max_orphan_tx_requests=10

# Set the maximum number of bytes to request from a peer
max_peer_request_bytes=1000000

# Set the maximum number of seconds to wait for a response to a peer request
peer_request_timeout=30

# Set the maximum number of messages to store in the mempool
mempool_max_messages=50000

# Set the maximum number of transactions per second to allow in the mempool
mempool_max_tps=30

# Write the bitcoin configuration file
cat <<EOF > "$bitcoin_conf"
proxy=$proxy 
rpcuser=$rpcuser
rpcpassword=$rpcpassword
rpcport=$rpcport
rpcallowip=$listen_address
rpcbind=$listen_address
data_dir=$data_dir
maxconnections=$max_connections
dbcache=$db_cache
maxmempool=$mempool_size
blockmaxsize=$max_block_size
maxtxsize=$max_tx_size
minrelaytxfee=$min_tx_fee
maxorphantx=$max_orphan_txs
maxdownloadheaders=$max_headers
cbfmemory=$cbf_memory
orphan_tx_keep_alive=$orphan_tx_keep_alive
cb_cache_time=$cb_cache_time
cb_send_targets=$cb_send_targets
maxoutboundpeers=$max_outbound_peers
maxinboundpeers=$max_inbound_peers
maxaddnodeconnections=$max_add_node_connections
addnodeperiod=$add_node_period
target_block_time=$target_block_time
max_future_block_time=$max_future_block_time
max_old_block_time=$max_old_block_time
blockfilecachesize=$block_file_cache_size
blockfilecachesizemb=$block_file_cache_size_mb
maxorphantxrequests=$max_orphan_tx_requests
maxpeerrequestbytes=$max_peer_request_bytes
peerrequesttimeout=$peer_request_timeout
mempoolmaxmessages=$mempool_max_messages
mempoolmaxtps=$mempool_max_tps
dnsseed=0
EOF

# Set the correct file permissions for the bitcoin configuration file  ensures that only the owner can read and modify the bitcoin configuration file.
chmod 0600 "$bitcoin_conf"