#!/bin/sh
## Setup machine as a git server (assumes git is installed)

# Add git user
adduser git
# Create a new user to manage the Git repositories
adduser git
# Configure the Git user's shell to limit access to Git operations only
chsh git -s "$(which git-shell)"
