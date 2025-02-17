#!/bin/bash

# Simple stow script
# It stows all directories in this repo with target specified in .stowrc to $HOME
# You can run it with additional param like -D to delete simlinks

for dir in */; do
	stow $dir -v $1 ${key}
done
