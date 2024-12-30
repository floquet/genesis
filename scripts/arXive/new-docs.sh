#!/usr/bin/env bash
printf "%s\n" "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# ===========================================================
# Script: new-docs.sh
# Purpose: Creates a new document or presentation project
# Features:
# - Dynamically sets the document type (--type docs|pres)
# - Modular design with sub-scripts for directory creation and file seeding
# - Tracks elapsed time and provides clear step-wise logs
# ===========================================================

# Record the start time
start_time=$SECONDS  

# Counts steps in batch process
export counter=0
function new_step() {
    counter=$((counter + 1))
    echo ""
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Step ${counter}: $1"
}

# ===========================================================
# Argument Parsing
# ===========================================================
if [ $# -eq 0 ]; then
    echo "Error: No DOCUMENT_NAME supplied."
    echo "Usage: $0 [--type docs|pres] <DOCUMENT_NAME>"
    exit 1
fi

# Parse document type with default to "docs"
TYPE="docs"
if [ "$1" == "--type" ]; then
    TYPE=$2
    shift 2
fi

DOCUMENT_NAME=$1
BASE_DIR=~/GitHub/genesis/$TYPE
DOCUMENT_DIR="$BASE_DIR/$DOCUMENT_NAME"

# ===========================================================
# Process Steps
# ===========================================================

# Step 1: Create directories
new_step "Creating directories for $TYPE document: $DOCUMENT_DIR"
./common/create-directories.sh "$DOCUMENT_DIR"

# Step 2: Seed files
new_step "Seeding files for $TYPE document: $DOCUMENT_NAME"
./common/seed-files.sh "$TYPE" "$DOCUMENT_DIR" "$DOCUMENT_NAME"

# ===========================================================
# Completion
# ===========================================================

echo ""
echo "Document $DOCUMENT_NAME created successfully in $TYPE!"
elapsed=$((SECONDS - start_time))  # Calculate elapsed time
echo "Time used = ${elapsed} sec"

