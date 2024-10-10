#!/bin/sh

RC='\033[0m'
RED='\033[31m'
YELLOW='\033[33m'
CYAN='\033[36m'
GREEN='\033[32m'

printf "%b\n" "${YELLOW}Macutil by Jadedzilla\n****************************${RC}"

# Scripts directory
scripts_dir="./scripts"

# Check if the directory exists
if [ ! -d "$scripts_dir" ]; then
    printf "%b\n" "${RED}Error: The scripts directory does not exist.${RC}" >&2
    exit 1
fi

# List files in the scripts directory, one per line
printf "%b\n" "${CYAN}Scripts:${RC}"
find "$scripts_dir" -maxdepth 1 -type f -exec basename {} \; | sort | sed 's/^/- /'