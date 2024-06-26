#!/bin/bash

# Switch to the production branch
git checkout production

# Update the production branch with the latest changes from the master branch
git merge --ff-only master

# Push the changes to the remote production branch
git push origin production

# Switch back to the master branch
git checkout master
