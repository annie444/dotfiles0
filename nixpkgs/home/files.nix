{ config, lib, ... }:
{
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.vimdiffAlias = true;
  programs.neovim.withNodeJs = true;
  programs.neovim.withPython3 = true;
  programs.neovim.withRuby = true;

  home.file = {
    ".wakatime.cfg" = {
      source = ../rcfiles/wakatime.cfg;
      enable = true;
    };
    ".npmrc" = {
      source = ../rcfiles/.npmrc;
      enable = true; 
    };
    ".iftoprc" = {
      source = ../rcfiles/iftop;
      enable = true; 
    };
    ".blsdatarc" = {
      source = ../rcfiles/bls;
      enable = true; 
    };
    ".fern/id" = {
      source = ../rcfiles/fern/id;
      enable = true; 
    };
    ".fern/token" = {
      source = ../rcfiles/fern/token;
      enable = true; 
    };
    ".config/spotify-tui/.spotify_token_cache.json" = {
      source = ../rcfiles/spotify;
      enable = true; 
    };
    ".config/lazygit/config.yml" = {
      source = ../rcfiles/lazygit;
      enable = true; 
    };
    ".config/gh-dash/config.yml" = {
      source = ../rcfiles/dash;
      enable = true; 
    };
    ".config/gh-changelog/.changelog.yml" = {
      source = ../rcfiles/changelog;
      enable = true;
    };
    ".config/cheat/cheatsheets" = {
      source = ../rcfiles/cheatsheets;
      recursive = true;
      enable = true;
    };
    "iTerm/Colors" = {
      source = ../rcfiles/iterm;
      recursive = true;
      enable = true;
    };
    ".tmux/yank.sh" = {
      source = ../rcfiles/tmux/yank.sh;
      enable = true;
    };
    ".tmux/tmux.remote.conf" = {
      source = ../rcfiles/tmux/tmux.remote.conf;
      enable = true;
    };
  };
}
