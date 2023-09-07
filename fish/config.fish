set -U fish_term24bit 1

zoxide init fish | source

status --is-interactive; and begin
    # Aliases
    alias .. 'cd ..'
    alias :q exit
    alias cat 'bat'
    alias drb 'darwin-rebuild build --flake /Users/annieehler/.config/nixpkgs'
    alias drs 'darwin-rebuild switch --flake /Users/annieehler/.config/nixpkgs'
    alias du 'dust'
    alias flakeup 'nix flake update /Users/annieehler/.config/nixpkgs'
    alias g 'git'
    alias gh 'op plugin run -- gh'
    alias la 'll -a'
    alias ll 'ls -l --time-style long-iso --icons'
    alias ls 'exa -@la --icons'
    alias nb 'nix build'
    alias nd 'nix develop'
    alias nf 'nix flake'
    alias nr 'nix run'
    alias ns 'nix search'
    alias vimdiff 'nvim -d'
    base16-dracula
    set -g fish_greeting ""
    thefuck --alias | source
    if set -q KITTY_INSTALLATION_DIR
        source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
        set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
    end
    begin
        set -l joined (string join " " $fish_complete_path)
        set -l prev_joined (string replace --regex "[^\s]*generated_completions.*" "" $joined)
        set -l post_joined (string replace $prev_joined "" $joined)
        set -l prev (string split " " (string trim $prev_joined))
        set -l post (string split " " (string trim $post_joined))
        set fish_complete_path $prev "/Users/annieehler/.local/share/fish/home-manager_generated_completions" $post
    end
    direnv hook fish | source
    starship init fish | source
end
