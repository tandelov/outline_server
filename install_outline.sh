#!/bin/bash

# Check for the IP_SERVER argument
if [ -z "$1" ]; then
  echo "Usage: $0 IP_SERVER"
  exit 1
fi

IP_SERVER="$1"

# Prompt for sudo password at the beginning
sudo -v

# Command 1: Download the install script
wget https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh

# Check if the download was successful
if [ ! -f install_server.sh ]; then
    echo "Failed to download install_server.sh"
    exit 1
fi

# Command 2: Edit the install_server.sh script
# Use 'sed' to find the line containing '-restart always --net host' within the function start_shadowbox
# and replace it with the new desired line.
sed -i "/start_shadowbox/,/}/ s|-restart always --net host|--restart always -t 1080:1080 -p 8080:8080|" install_server.sh

# Command 3: Make the script executable
sudo chmod +x ./install_server.sh

# Command 4: Run the script with the specified options
sudo ./install_server.sh --api-port 1080 --keys-port 8080 --hostname "$IP_SERVER"
