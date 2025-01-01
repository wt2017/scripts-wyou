#!/bin/bash
# remove-untagged.sh

# Request sudo privileges at the start
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with sudo"
    exec sudo "$0" "$@"
fi

# List dangling images first
echo "Untagged images to be removed:"
podman images -f "dangling=true"

# Remove dangling images
echo "Removing untagged images..."
podman rmi $(podman images -f "dangling=true" -q)
