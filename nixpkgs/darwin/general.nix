{ pkgs, ... }:

{
  # Networking
  networking.dns = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    iterm2
    kitty
    terminal-notifier
  ];
  environment.darwinConfig = "$HOME/.config/nixpkgs";
  environment.pathsToLink = [ "/share/zsh" ];
  programs.nix-index.enable = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
     recursive
     (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
   ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
