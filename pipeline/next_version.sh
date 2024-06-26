#!/bin/bash

# Get the next version string based on the date and previous tagged builds

MAJOR=$(cat VERSION | tr -d '\n')
NOW=$(TZ=UTC date +%y.%m)
PREFIX=v$MAJOR.$NOW

echo "Finding latest build for $PREFIX" >&2

LATEST=$(git tag -l "$PREFIX*" | sort -r | head -1)

if [[ $LATEST ]]; then
    echo "Found $LATEST" >&2
    PARTS=( ${LATEST//./ } )
    NEXT_BUILD=$((10#${PARTS[3]}+ 1))
    NEW_BUILD_NUM="$(printf %04d $NEXT_BUILD)"
else
    echo "No build found. Starting a new series." >&2
    NEW_BUILD_NUM="0001"
fi
echo $PREFIX.$NEW_BUILD_NUM

