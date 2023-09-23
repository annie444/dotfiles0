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
      curl # HTTP fetcher
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
      thefuck # Shell spellcheck
      tmux # terminal multiplexer
      tree # dir-tree
      unrar # extract RAR archives
      upterm # secure terminal sharing
      vbindiff # advanced diff
      vivid # fancy terminal colors
      wget # HTTP fetcher
      xz # extract XZ archives
    ;
    
    # Media handling
    inherit (pkgs) 
      mpi # message passing interface
      blas # Linear algebra and matrix algebra libraries and packages
      hdf5 # HDF5 file and encoding libraries and packages
      imagemagick # Image pressessing libraries and packages
      gnuplot # GNU plotting libraries and packages
      graphviz # Graph visualization software
      vtk # Visualization toolkit
      spotify-tui # Spotify teminal user interface
    ;

    inherit (pkgs.python310Packages)
      pyqt5 # QT5 with python libraries
    ;
    
    # C/C++ libs
    inherit (pkgs)
      armadillo # Linear algebra and graphics computing library
      bear # Auto-create compiler wrapping
      dlib # ML/AI library
      gsl # C/C++ guidelines and support
      libpqxx # C/C++ PostgreSQL bindings
    ;

    # CLI Libs and headers
    inherit (pkgs)
      pango # Text rending library
      ncurses # Terminal visualization library
      libusb1 # USB protocols and drivers
      libllvm # LLVM compiler collection
      cmake # C-Make softwares
      libclang # CLANG compiler
      mkvtoolnix # Video and Document encoding libraries
      opencv # Computer Vision libraries
      thrift # RPC protocols libraries
    ;

    # Docker
    inherit (pkgs)
      docker # docker base
      docker-gc # docker garbage collector
      docker-ls # docker listing and database
      docker-sync # docker swarm synchronization
      docker-slim # docker runtime (slim)
      docker-buildx # BuildX runtime
      docker-machine # Machine virtualization runtime
      docker-compose # Docker compose toolkit
      docker-distribution # Docker image distribution
      docker-credential-gcr # Docker credentials helper for Google Container Registry
      docker-credential-helpers # Docker credentials libraries
      lazydocker # Docker terminal user interface
      cargo-chef # Rust Cargo tooling for Docker
      dive # Image layer analysis tools
    ;

    inherit (pkgs.luajitPackages) 
      luarocks # lua package manager
    ;

    inherit (pkgs.nodePackages)
      gitmoji-cli # Emoji protocols for CLI
    ;

    # Dev stuff
    inherit (pkgs)
      cloc # source code line counter
      github-copilot-cli # Copilot
      ruby # Ruby runtime
      cargo-udeps # cargo unused dependency tools
      rustup # rust installation and management tool
      ghostscript # PostScript and PDF language runtime
      jqp # JSON terminal user interface
      julia-bin # Julia runtime
      lua # Lua runtime
      lua-language-server # Lua language server
      marksman # Mardown language server
      perl # Perl runtime
      coursier # Scala package manager and language server
      scala # scala runtime
      php # PHP runtime
      tetex # LaTeX runtime and interpreter
      jdk # Java virtual machine
      python3Full # Python complete language 
      jq # JSON terminal parser
      nodejs # NodeJS runtime
      yarn # Yarn (NodeJS) runtime and package manager
      terraform # terraform runtime and language server
      copilot-cli # Github copilot
      typescript # typescript language server
      certbot # CA Certivicates (ACME) daemon
      coreutils-full # Core utilities
      git-extras # git command API
      grpcurl # gRPC tooling
      kubernetes-helm # helm (kubectl) package manager
      kubectx # kubernetes context manager
      kubectl # kuberenetes control manager
      nix-prefetch-scripts # NIX CLI dev tooling
      kustomize # kubernetes templating language
      lazygit # Git terminal user interface
      mkcert # CA Certificates and trust handler
      postgresql # PostgreSQL runtime
      redis # Redis runtime
      sampler # TUI designer
      subversion # version manager
      upx # executible compression package
      wireguard-go # wireguard VPN runtime
      chromedriver # chromium development base
      powershell # Microsoft powershell
      ninja # C-Make alternative
      virtualenv # Python virtual environemnt manager
      poetry # Pythong packinging tools
      ruff # Pything linter
      mercurialFull # version management system
      tree-sitter # file syntax tree
      gzip # GNU file compression tools
      gofumpt # go formatter
      go # go language runtime and compiler
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
