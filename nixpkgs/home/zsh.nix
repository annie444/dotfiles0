{ config, lib, pkgs, ... }:

let
  inherit (lib) elem optionalString;
  inherit (config.home.user-info) nixConfigDirectory;
in

{
  programs.zsh.enable = true;
  # Zsh Shell
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autocd = true;
  programs.zsh.dotDir = ".config/zsh";
  programs.zsh.history = {
    expireDuplicatesFirst = true;
    extended = false;
    ignoreAllDups = true;
    path = "$ZDOTDIR/.zsh_history";
    save = 100000;
    share = true;
    size = 100000;
  };
  programs.zsh.completionInit = "autoload -U compinit && compinit";
  programs.zsh.defaultKeymap = "viins";
  programs.zsh.historySubstringSearch = {
    enable = true;
    searchDownKey = [ "^[[B" ];
    searchUpKey = [ "^[[A" ];
  };
  programs.zsh.localVariables = {
    BAT_THEME="Monokai Extended Origin";
    FZF_DEFAULT_OPTS="--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284";
    OP_BIOMETRIC_UNLOCK_ENABLED=true;
    LS_COLORS="$(vivid generate dracula)";
    USE_GKE_GCLOUD_AUTH_PLUGIN=true;
  };
  programs.zsh.initExtraFirst = 
    ''
      if [[ -r "$HOME/.cache/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "$HOME/.cache/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi
      if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi
    '';

  programs.zsh.antidote.enable = true;
  programs.zsh.antidote.package = pkgs.antidote;
  programs.zsh.antidote.plugins = [
    "zdharma-continuum/fast-syntax-highlighting"
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-history-substring-search"
    "MichaelAquilina/zsh-you-should-use"
    "nix-community/nix-zsh-completions"
    "romkatv/powerlevel10k"
  ];
  programs.zsh.antidote.useFriendlyNames = true;

  programs.zsh.shellAliases = with pkgs; {
    drb = "darwin-rebuild build --flake ${nixConfigDirectory}";
    drs = "darwin-rebuild switch --flake ${nixConfigDirectory}";
    flakeup = "nix flake update ${nixConfigDirectory}";
    nb = "nix build";
    nd = "nix develop";
    nf = "nix flake";
    nr = "nix run";
    ns = "nix search";
    fzf = "${fzf}/bin/fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    spotify = "${spotify-tui}/bin/spt";
    ls = "${exa}/bin/exa -@la --icons";
    cat = "${bat}/bin/bat";
    du = "${du-dust}/bin/dust";
    g = "${gitAndTools.git}/bin/git";
    la = "ll -a";
    ll = "ls -l --time-style long-iso --icons";
  };

  programs.zsh.initExtraBeforeCompInit = ''
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    test -e "''${HOME}/.iterm2_shell_integration.zsh" && source "''${HOME}/.iterm2_shell_integration.zsh"

    zstyle ':completion:*' add-space true
    zstyle ':completion:*' auto-description 'specify: %d'
    zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate _prefix
    zstyle ':completion:*' completions 1
    zstyle ':completion:*' file-sort modification
    zstyle ':completion:*' format 'Completing %d'
    zstyle ':completion:*' glob 1
    zstyle ':completion:*' group-name ""
    zstyle ':completion:*' ignore-parents parent directory
    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
    zstyle ':completion:*' match-original both
    zstyle ':completion:*' matcher-list "" 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**'
    zstyle ':completion:*' max-errors 3
    zstyle ':completion:*' menu select=3
    zstyle ':completion:*' preserve-prefix '//[^/]##/'
    zstyle ':completion:*' prompt '%e corrections'
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    zstyle ':completion:*' special-dirs true
    zstyle ':completion:*' squeeze-slashes true
    zstyle ':completion:*' substitute 1
    zstyle ':completion:*' use-compctl true
    zstyle ':completion:*' verbose true
    zstyle ':completion:*' word true
    zstyle :compinstall filename '/Users/annieehler/.zshrc'
    '';

    programs.zsh.envExtra = ''
      if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi
      if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi
      export PATH=$HOME/google-cloud-sdk/bin:$PATH
    '';
}
