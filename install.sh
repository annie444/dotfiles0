#!/bin/sh

set -e
DIR=$(pwd)
DATE=$(date +%Y-%m-%d_%H-%M-%S)

if [ ! -d "${HOME}/.config/backups" ]; then
  mkdir "${HOME}/.config/backups"
fi
mkdir "${HOME}/.config/backups/${DATE}"

if [ -d "${HOME}/.config/fish" ]; then
  cp -Lr "${HOME}/.config/fish" "${HOME}/.config/backups/${DATE}/fish"
  rm -rd "${HOME}/.config/fish"
fi
ln -s "${DIR}/fish" "${HOME}/.config/fish"

if [ -d "${HOME}/.config/nixpkgs" ]; then
  cp -Lr "${HOME}/.config/nixpkgs" "${HOME}/.config/backups/${DATE}/nixpkgs"
  rm -rd "${HOME}/.config/nixpkgs"
fi
cp -r "${DIR}/nixpkgs" "${HOME}/.config/nixpkgs"

if [ -d "${HOME}/.config/nvim" ]; then
  cp -Lr "${HOME}/.config/nvim" "${HOME}/.config/backups/${DATE}/nvim" 
  rm -rd "${HOME}/.config/nvim"
fi
ln -s "${DIR}/nvim" "${HOME}/.config/nvim"

if [ -f "${HOME}/.p10k.zsh" ]; then
  cp -L "${HOME}/.p10k.zsh" "${HOME}/.config/backups/${DATE}/.p10k.zsh"
  rm -f "${HOME}/.p10k.zsh"
fi
ln -s "${DIR}/.p10k.zsh" "${HOME}/.p10k.zsh"

if [ -f "${HOME}/.config/starship.toml" ]; then
  cp -L "${HOME}/.config/starship.toml" "${HOME}/.config/backups/${DATE}/starship.toml"
  rm -f "${HOME}/.config/starship.toml"
fi
ln -s "${DIR}/starship.toml" "${HOME}/.config/starship.toml"

if [ -d "${DIR}/copilot" ]; then
  cp -Lr "${HOME}/.config/github-copilot" "${HOME}/.config/backups/${DATE}/github-copilot"
  rm -rf "${HOME}/.config/github-copilot"
  ln -s "${DIR}/copilot" "${HOME}/.config/github-copilot"
fi

sudo ln -s "${DIR}/dotup" /usr/local/bin/
if [[ "${DIR}" != "${HOME}/.config/dotfiles" ]]; then
  cd "${HOME}"
  mv "${DIR}" "${HOME}/.config/dotfiles"
fi
