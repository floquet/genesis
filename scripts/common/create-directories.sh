#!/usr/bin/env bash
printf "%s\n" "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# Arguments: $1 = DOCUMENT_DIR
DOCUMENT_DIR=$1

if [ -z "$DOCUMENT_DIR" ]; then
    echo "Error: DOCUMENT_DIR is not specified."
    exit 1
fi

# Directory structure
SUBDIRS=(
    "config"
    "sections"
    "main/tags"
    "local/achates"
    "local/code"
    "local/data"
    "local/debug"
    "local/graphics"
    "local/refs"
    "local/components/figs"
    "local/components/tabs"
    "local/components/thms"
)

# Create directories
for SUBDIR in "${SUBDIRS[@]}"; do
    mkdir -p "$DOCUMENT_DIR/$SUBDIR"
    echo "Created: $DOCUMENT_DIR/$SUBDIR"
done
