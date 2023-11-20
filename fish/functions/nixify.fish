function nixify
  if not test -e ./.envrc ]
    echo "use nix" > .envrc
    direnv allow
  end
  if not -e shell.nix; and not test -e default.nix
    echo "\
with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
  ];
} 
" | cat > default.nix

    nvim default.nix
  end

end
