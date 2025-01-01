#!/bin/bash

# Check if directory path is provided as argument
if [ -z "$1" ]; then
    echo "Usage: $0 <output_directory>"
    exit 1
fi

# Create output directory if it doesn't exist
OUTPUT_DIR="$1"
mkdir -p "$OUTPUT_DIR"

for img in $(docker images --format "{{.Repository}}:{{.Tag}}" | grep -v "<none>"); do
    filename=$(echo $img | tr '/:|' '_')
    echo "Saving $img to ${OUTPUT_DIR}/${filename}.tar"
    docker save $img -o "${OUTPUT_DIR}/${filename}.tar"
done
