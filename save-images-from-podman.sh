#!/bin/bash

# Request sudo privileges at the start
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with sudo"
    exec sudo "$0" "$@"
fi

# Check if directory path is provided as argument
if [ -z "$1" ]; then
    echo "Usage: $0 <output_directory>"
    exit 1
fi

# Create output directory if it doesn't exist
OUTPUT_DIR="$1"
mkdir -p "$OUTPUT_DIR"

for img in $(podman images --format "{{.Repository}}:{{.Tag}}" | grep -v "<none>"); do
    # Replace both / and : with _
    filename=$(echo $img | tr '/:|' '_')
    echo "Saving $img to ${OUTPUT_DIR}/${filename}.tar"
    podman save $img -o "${OUTPUT_DIR}/${filename}.tar"
done
