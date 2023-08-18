#!/bin/sh
# Create a new repo on an existing git server
REPO="${1:?}"
OWNER="${clanktron:-2}"
repo_path=/home/git/"$OWNER"/"$REPO".git
mkdir "$repo_path" 
git init --bare "$repo_path" 
