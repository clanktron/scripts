#!/bin/sh
# Create a new repo on an existing git server
# REPO="${1:?}"
REPO=concurrent-hash
repo_path=/home/git/"$REPO".git
mkdir "$repo_path" 
git init --bare "$repo_path" 
