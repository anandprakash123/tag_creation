#!/bin/bash
# Retrieve the latest version tag
latest_version=$(git describe --tags `git rev-list --tags --max-count=1`)

# Extract the major, minor, and patch numbers from the latest version
regex="^([0-9]+)\.([0-9]+)\.([0-9]+)$"
if [[ $latest_version =~ $regex ]]; then
    major="${BASH_REMATCH[1]}"
    minor="${BASH_REMATCH[2]}"
    patch="${BASH_REMATCH[3]}"
else
    major="1"
    minor="0"
    patch="0"
fi

# Convert the extracted numbers to integers
major=$((major))
minor=$((minor))
patch=$((patch))

# Increment the patch number to generate the next version
next_patch=$((patch - 1))
if [[ $next_patch -le 0 ]]; then
        next_patch="0"
fi

echo "${major}.${minor}.${next_patch}"
