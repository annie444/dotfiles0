#!/bin/sh

DATE=$(date +%Y-%m-%d_%H-%M-%S)

sudo mv /etc/bashrc "/etc/bashrc.$DATE"
sudo mv /etc/zshrc "/etc/zshrc.$DATE"
sudo mv /etc/zprofile "/etc/zprofile.$DATE"
sudo /nix/var/nix/profiles/system/activate
