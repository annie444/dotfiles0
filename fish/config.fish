set -U fish_term24bit 1

zoxide init fish | source

if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end
set -e NIX_REMOTE

set -U EDITOR nvim

status --is-interactive; and begin
    # Aliases
    alias .. 'cd ..'
    alias :q exit
    alias cat 'bat'
    alias drb 'darwin-rebuild build --flake $HOME/.config/nixpkgs'
    alias drs 'darwin-rebuild switch --flake $HOME/.config/nixpkgs'
    alias du 'dust'
    alias flakeup 'nix flake update $HOME/.config/nixpkgs'
    alias g 'git'
    alias la 'll -a'
    alias ll 'ls -l --time-style long-iso --icons'
    alias ls 'eza --extended --bytes --links --blocksize --group --header --dereference --binary --octal-permissions --git --git-repos --long --all --all --icons --grid --classify --hyperlink --group-directories-first --time=modified --sort=extension --color=always --width=1 --time-style=long-iso'
    alias nb 'nix build'
    alias nd 'nix develop'
    alias nf 'nix flake'
    alias nr 'nix run'
    alias ns 'nix search'
    alias vimdiff 'nvim -d'
    alias find 'bfs'
    alias fd 'bfs'
    alias gd 'batdiff'
    alias bathelp 'bat --plain --language=help'
    base16-dracula
    set -g fish_greeting ""
    thefuck --alias | source
    if set -q KITTY_INSTALLATION_DIR
        source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
        set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
    end
    begin
        set -g MANPAGER "sh -c 'col -bx | bat -l man -p'"
        set -l joined (string join " " $fish_complete_path)
        set -l prev_joined (string replace --regex "[^\s]*generated_completions.*" "" $joined)
        set -l post_joined (string replace $prev_joined "" $joined)
        set -l prev (string split " " (string trim $prev_joined))
        set -l post (string split " " (string trim $post_joined))
        set fish_complete_path $prev "$HOME/.local/share/fish/home-manager_generated_completions" $post
        set -g PATH  $PATH "$HOME/google-cloud-sdk/bin" "$HOME/.cargo/bin" "$HOME/.local/bin" "$HOME/bin"
        set -g direnv_fish_mode eval_on_arrow
        set -g USE_GKE_GCLOUD_AUTH_PLUGIN true
        set -g BAT_THEME dracula
        set -g LDFLAGS $LDFLAGS "-F/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/"
        set -g JAVA_HOME "/Applications/Android Studio.app/Contents/jbr/Contents/Home"
        set -g ANDROID_HOME "$HOME/Library/Android/sdk"
        set -g NDK_HOME "$ANDROID_HOME/ndk/25.0.8775105"
        set -g SSH_AUTH_SOCK "~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        set -g TERM "xterm-256color"
        set -g -x CC "/etc/profiles/per-user/annieehler/bin/clang"
    end
    
    direnv hook fish | source
    starship init fish | source
    
    # pnpm
    set -gx PNPM_HOME "/Users/annieehler/Library/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
      set -gx PATH "$PNPM_HOME" $PATH
    end
    # pnpm end

    direnv hook fish | source
    source ~/.config/op/plugins.sh
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/annieehler/miniforge3/bin/conda
    eval /Users/annieehler/miniforge3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

