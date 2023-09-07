!#/bin/sh

function install() 
{
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  source install.sh
}

if [[ $(uname) == "Darwin"* ]]; then
  echo "Installing darwin setup..."
  sh <(curl -L https://nixos.org/nix/install)
  nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
  ./result/bin/darwin-installer
  mv /etc/bashrc /etc/bashrc.before-nix-darwin
  install
  darwin-rebuild switch --flake ~/.config/nixpkgs
elif [[ $(uname) == "Linux"* ]]; then
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ $NAME != "NixOS"* ]]; then
      echo "Installing nix package manager..."
      sh <(curl -L https://nixos.org/nix/install) --daemon
      install
      home-manager switch --flake ~/.config/nixpkgs
    elif [[ $NAME == "NixOS"* ]]; then
      install
      home-manager switch --flake ~/.config/nixpkgs
    fi
  fi
fi






