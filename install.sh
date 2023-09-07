#!/bin/sh

set -e
DIR=$(pwd)

mv ~/.config/fish ~/.config/fish.bak
ln -s "${DIR}/fish" ~/.config/fish

mv ~/.config/nixpkgs ~/.config/nixpkgs.bak
ln -s "${DIR}/nixpkgs" ~/.config/nixpkgs

mv ~/.config/nvim ~/.config/nvim.bak 
ln -s "${DIR}/nvim" ~/.config/nvim

mv ~/.p10k.zsh ~/.p10k.zsh.bak
ln -s "${DIR}/.p10k.zsh" ~/.p10k.zsh

mv ~/.config/starship.toml ~/.config/starship.toml.bak
ln -s "${DIR}/starship.toml" ~/.config/starship.toml

if [ -d "${DIR}/copilot" ]; then
  mv ~/.config/github-copilot ~/.config/github-copilot.bak
  ln -s "${DIR}/copilot" ~/.config/github-copilot
fi
