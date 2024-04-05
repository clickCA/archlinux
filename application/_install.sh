#!/bin/bash

# Loop through all .sh files in the current directory
for file in *.sh; do
    # Check if the file is executable
    if [[ -x "$file" ]]; then
        # Run the file
        "./$file"
    fi
done