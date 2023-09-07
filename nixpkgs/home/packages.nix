{ lib, pkgs, ... }:

{
  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat.enable = true;
  programs.bat.config = {
    style = "plain";
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # SSH
  # https://nix-community.github.io/home-manager/options.html#opt-programs.ssh.enable
  # Some options also set in `../darwin/homebrew.nix`.
  programs.ssh.enable = true;
  programs.ssh.controlPath = "~/.ssh/%C"; # ensures the path is unique but also fixed length

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;

  home.packages = lib.attrValues ({
    # Some basics
    inherit (pkgs)
      abduco # lightweight session management
      bandwhich # display current network utilization by process
      bfs # bredth first `find`
      bottom # fancy version of `top` with ASCII graphs
      btop # `htop` built in rust
      browsh # in terminal browser
      cheat # cheatsheets for terminal
      curl
      dooit # to-do manager
      du-dust # fancy version of `du`
      exa # fancy version of `ls`
      fd # fancy version of `find`
      fzf # fuzzy finder
      fzy # limited fuzzy finder
      gawk # faster awk
      gh # github cli
      git # version management
      gotop # low-level top
      htop # fancy version of `top`
      hyperfine # benchmarking tool
      iftop # `htop` for network traffic
      lsd # fancy `ls`
      mosh # wrapper for `ssh` that better and not dropping connections
      most # better less
      neofetch # better wget and curl
      nmap # map netowork traffic
      notcurses # GUI compat for terminals
      parallel # runs commands in parallel
      ripgrep # better version of `grep`
      rsync # ssh compatible network file manager
      skim # terminal condenser
      tealdeer # rust implementation of `tldr`
      thefuck
      tmux # terminal multiplexer
      tree # dir-tree
      unrar # extract RAR archives
      upterm # secure terminal sharing
      vbindiff # advanced diff
      vivid # fancy terminal colors
      wget
      xz # extract XZ archives
    ;
    
    # Media handling
    inherit (pkgs) 
      mpi
      blas
      hdf5
      imagemagick
      gnuplot
      graphviz
      vtk
      spotify-tui
    ;

    inherit (pkgs.python310Packages)
      pyqt5
    ;
    
    # C/C++ libs
    inherit (pkgs)
      armadillo
      bear
      dlib
      gsl
      libpqxx
    ;

    # CLI Libs and headers
    inherit (pkgs)
      pango
      ncurses
      libusb1
      libllvm
      mkvtoolnix
      opencv
      thrift
    ;

    # Docker
    inherit (pkgs)
      docker
      docker-gc
      docker-ls
      docker-sync
      docker-slim
      docker-buildx
      docker-machine
      docker-compose
      docker-distribution
      docker-credential-gcr
      docker-credential-helpers
      lazydocker
      cargo-chef
      dive
    ;

    inherit (pkgs.luajitPackages) 
      luarocks
    ;

    inherit (pkgs.nodePackages)
      gitmoji-cli
    ;

    # Dev stuff
    inherit (pkgs)
      cloc # source code line counter
      github-copilot-cli
      ruby
      cargo-udeps
      rustup 
      ccls
      ghostscript
      jqp
      julia-bin
      lua
      lua-language-server
      marksman
      perl
      coursier
      scala
      php
      tetex
      jdk
      python3Full
      jq
      nodejs
      yarn
      s3cmd
      terraform
      copilot-cli
      nix-prefetch-github
      stack
      typescript
      libclang
      certbot
      cmake
      cmctl
      coreutils-full
      git-extras
      grpcurl
      kubernetes-helm
      kind
      kubectl
      kustomize
      lazygit
      mkcert
      postgresql
      redis
      sampler
      subversion
      upx
      wireguard-go
      chromedriver
      powershell
      ninja
      virtualenv
      poetry
      ruff
    ;
    
    # Useful nix related tools
    inherit (pkgs)
      comma # run software from without installing it
      nix-output-monitor # get additional information while building packages
      nix-tree # interactively browse dependency graphs of Nix derivations
      nix-update # swiss-knife for updating nix packages
      nixpkgs-review # review pull-requests on nixpkgs
      node2nix # generate Nix expressions to build NPM packages
      statix # lints and suggestions for the Nix programming language
    ;

  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    inherit (pkgs)
      cocoapods
      m-cli # useful macOS CLI commands
      prefmanager # tool for working with macOS defaults
    ;
  });
}
