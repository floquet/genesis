#!/usr/bin/env bash
printf "%s\n" "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

DOCUMENT_DIR=$1

# Define subdirectories
SUBDIRS=(
    "config"
    "sections"
    "main/tags"
    "local/config"
    "local/graphics"
    "local/refs"
    "local/components/figs"
    "local/components/tabs"
    "local/components/thms"
    "local/debug"
)

echo "Creating directories for $DOCUMENT_DIR"
for SUBDIR in "${SUBDIRS[@]}"; do
    mkdir -p "$DOCUMENT_DIR/$SUBDIR"
    echo "Created: $DOCUMENT_DIR/$SUBDIR"
done
