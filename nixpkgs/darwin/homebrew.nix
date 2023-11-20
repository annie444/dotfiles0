{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf elem;
  caskPresent = cask: lib.any (x: x.name == cask) config.homebrew.casks;
  brewEnabled = config.homebrew.enable;
  homePackages = config.home-manager.users.${config.users.primaryUser.username}.home.packages;
in

{
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
  # For some reason if the Fish completions are added at the end of `fish_complete_path` they don't
  # seem to work, but they do work if added at the start.
  programs.zsh.interactiveShellInit = mkIf brewEnabled ''
    if type brew &>/dev/null; then
      export FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    fi
  '';

  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/services"
    "nrlquaker/createzap"
  ];

  # Prefer installing application from the Mac App Store
  homebrew.masApps = {
    "1Password for Safari" = 1569813296;
    "Accelerate for Safari" = 1459809092;
    Keynote = 409183694;
    Numbers = 409203825;
    Pages = 409201541;
    Slack = 803453959;
    "Tailscale" = 1475387142;
    "1Blocker - Ad Blocker" = 1365531024;
    "Super Agent for Safari" = 1568262835;
    "Magnet" = 441258766;
    "Spark Classic – Email App" = 1176895641;
    "Affinity Photo 2" = 1616822987;
    "Affinity Designer 2" = 1616831348;
    "Affinity Publisher 2" = 1606941598;
    "Motion" = 434290957;
    "Logic Pro" = 634148309;
    "Final Cut Pro" = 424389933;
    "MainStage" = 634159523;
    "Compressor" = 424390742;
    "PiPifier" = 1160374471;
    "Amphetamine" = 937984704;
    "Messenger" = 1480068668;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "1password"
    "1password-cli"
    "anki"
    "arduino-ide"
    "balenaetcher"
    "bartender"
    "breaktimer"
    "cleanmymac"
    "element"
    "discord"
    "firefox"
    "fontforge"
    "google-chrome"
    "google-drive"
    "gpg-suite"
    "hex-fiend"
    "inkscape"
    "iterm2"
    "logitech-g-hub"
    "loopback"
    "malwarebytes"
    "messenger"
    "nextcloud"
    "notion"
    "pastebot"
    "pocket-casts"
    "postman"
    "qbittorrent"
    "mullvadvpn"
    "signal"
    "sloth"
    "spotify"
    "steam"
    "tor-browser"
    "transmission"
    "transmit"
    "visual-studio-code"
    "vlc"
    "zoom"
    "libreoffice"
  ];

  # Configuration related to casks
  home-manager.users.${config.users.primaryUser.username} =
    mkIf (caskPresent "1password-cli" && config ? home-manager) {
      programs.ssh.enable = true;
      programs.ssh.extraConfig = ''
        # Only set `IdentityAgent` not connected remotely via SSH.
        # This allows using agent forwarding when connecting remotely.
        Match host * exec "test -z $SSH_TTY"
          IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      '';
      home.shellAliases = {
        gh = mkIf (elem pkgs.gh homePackages) "op plugin run -- gh";
      };
      home.sessionVariables = {
        GITHUB_TOKEN = "op://Personal/GitHub Personal Access Token/credential";
      };
    };

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews = [
    "swift-format"
    "swiftlint"
  ];
}
