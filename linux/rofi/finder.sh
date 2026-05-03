#!/usr/bin/env bash

# 1. If an argument is passed, it means the user selected a file
if [ ! -z "$@" ]; then
    # Expand ~ if present and open the file
    file_path=$(echo "$@" | sed "s#~#$HOME#")
    xdg-open "$file_path" > /dev/null 2>&1 &
    exit 0
fi

# 2. Otherwise, list files (customize directories/depth here)
# We use sed to make paths look prettier with ~
fd --type f --hidden --exclude .git . "$HOME" | sed "s#$HOME#~#