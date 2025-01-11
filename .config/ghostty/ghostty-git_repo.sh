#!/bin/bash

# Define the directory to search for Git repositories
SEARCH_DIR=~/hub

# Find all Git repositories and store them in an array
repos=()
while IFS= read -r gitdir; do
    # Get the parent directory name (the actual repo)
    repo_dir=$(dirname "$gitdir")
    repos+=("$repo_dir")
done < <(find "$SEARCH_DIR" -type d -name ".git")

# Use fzf to let the user select a repository
selected_repo=$(printf "%s\n" "${repos[@]}" | fzf --height 40% --layout=reverse --preview 'ls -1 {}' --preview-window=up:30%:wrap)

# Check if a repository was selected
if [ -n "$selected_repo" ]; then
    # Simulate Ctrl+A and C to create a new tab
    xdotool key ctrl+a c

    sleep 0.1

    # Change to the selected repository directory in the new tab
    xdotool type "cd \"$selected_repo\""
    xdotool key Return 
    xdotool key ctrl+l # clear screen
else
    echo "No repository selected."
fi

