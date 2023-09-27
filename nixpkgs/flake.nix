{
  description = "HomeManager Flake";

  inputs = {
    # Package sets
    nixpkgs-main.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    
    # Flake utilities
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-utils.url = "github:numtide/flake-utils";
    
    # Utility for watching macOS `defaults`.
    prefmanager.url = "github:malob/prefmanager";
    prefmanager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    prefmanager.inputs.flake-compat.follows = "flake-compat";
    prefmanager.inputs.flake-utils.follows = "flake-utils";

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, stylix, darwin, home-manager, flake-utils, ...}@inputs: 
    let
      inherit (self.lib) attrValues makeOverridable mkForce optionalAttrs singleton;

      homeStateVersion = "23.11";

      nixpkgsDefaults = {
        config = {
          allowUnfree = true;
        };
        overlays = attrValues self.overlays ++ [
          inputs.prefmanager.overlays.prefmanager
        ] ++ singleton (
          final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            # Sub in x86 version of packages that don't build on Apple Silicon.
            inherit (final.pkgs-x86)
              idris2
              nix-index
              niv
              purescript
            ;
          }) // {
             
          }
        );
      };

      primaryUserDefaults = {
        username = "annieehler";
        fullName = "Annie Ehler";
        email = "annie.ehler.4@gmail.com";
        nixConfigDirectory = "/Users/annieehler/.config/nixpkgs";
        shell = "${nixpkgs.fish}/bin/fish";
      };
    in
    {
      # Add some additional functions to `lib`.
      lib = inputs.nixpkgs-unstable.lib.extend (_: _: {
        mkDarwinSystem = import ./lib/mkDarwinSystem.nix inputs;
        lsnix = import ./lib/lsnix.nix;
      });

      overlays = {
        # Overlays to add different versions `nixpkgs` into package set
        pkgs-main = _: prev: {
          pkgs-main = import inputs.nixpkgs-main {
            inherit (prev.stdenv) system;
            inherit (nixpkgsDefaults) config;
          };
        };
        pkgs-stable = _: prev: {
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsDefaults) config;
          };
        };
        pkgs-unstable = _: prev: {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsDefaults) config;
          };
        };
        apple-silicon = _: prev: optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs-unstable {
            system = "x86_64-darwin";
            inherit (nixpkgsDefaults) config;
          };
        };

        tweaks = _: _: {
          # Add temporary overrides here
        };
      };

      darwinModules = {
        # My configurations
        annie-bootstrap = import ./darwin/bootstrap.nix;
        annie-defaults = import ./darwin/defaults.nix;
        annie-general = import ./darwin/general.nix;
        annie-homebrew = import ./darwin/homebrew.nix;

        # Modules I've created
        users-primaryUser = import ./modules/darwin/users.nix;
      };

      homeManagerModules = {
        styling = stylix.homeManagerModules.stylix;
        annie-styles = import ./home/stylix.nix;
        # My configurations
        annie-colors = import ./home/colors.nix;
        annie-config-files = import ./home/config-files.nix;
        annie-zsh = import ./home/zsh.nix;
        annie-fish = import ./home/fish.nix;
        annie-git = import ./home/git.nix;
        annie-git-aliases = import ./home/git-aliases.nix;
        annie-gh-aliases = import ./home/gh-aliases.nix;
        annie-kitty = import ./home/kitty.nix;
        annie-files = import ./home/files.nix;
        annie-packages = import ./home/packages.nix;
        annie-tmux = import ./home/tmux.nix;
        annie-starship = import ./home/starship.nix;
        annie-starship-symbols = import ./home/starship-symbols.nix;

        # Modules I've created
        colors = import ./modules/home/colors;
        programs-kitty-extras = import ./modules/home/programs/kitty/extras.nix;
        home-user-info = { lib, ... }: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
        };
      };

      programs.home-manager.enable = true;

      darwinConfigurations = {
        # Minimal macOS configurations to bootstrap systems
        bootstrap-x86 = makeOverridable darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [ ./darwin/bootstrap.nix { nixpkgs = nixpkgsDefaults; } ];
        };
        bootstrap-arm = self.darwinConfigurations.bootstrap-x86.override {
          system = "aarch64-darwin";
        };

        # My Apple Silicon macOS laptop config
        Annies-MacBook-Pro = makeOverridable self.lib.mkDarwinSystem (primaryUserDefaults // {
          modules = attrValues self.darwinModules ++ singleton {
            nixpkgs = nixpkgsDefaults;
            networking.computerName = "Annie’s 💻";
            networking.hostName = "Annies-MacBook-Pro";
            networking.knownNetworkServices = [
              "Wi-Fi"
              "USB 10/100/1000 LAN"
            ];
            nix.registry.my.flake = inputs.self;
          };
          extraModules = singleton { nix.linux-builder.enable = true; };
          inherit homeStateVersion;
          homeModules = attrValues self.homeManagerModules;
        });

        # Config with small modifications needed/desired for CI with GitHub workflow
        githubCI = self.darwinConfigurations.Annies-MacBook-Pro.override {
          system = "x86_64-darwin";
          username = "runner";
          nixConfigDirectory = "/Users/runner/work/nixpkgs/nixpkgs";
          extraModules = singleton {
            environment.etc.shells.enable = mkForce false;
            environment.etc."nix/nix.conf".enable = mkForce false;
            homebrew.enable = mkForce false;
          };
        };
      };

      # Config I use with non-NixOS Linux systems (e.g., cloud VMs etc.)
      # Build and activate on new system with:
      # `nix build .#homeConfigurations.malo.activationPackage && ./result/activate`
      homeConfigurations.annieehler = makeOverridable home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs-unstable (nixpkgsDefaults // { system = "x86_64-linux"; });
        modules = attrValues self.homeManagerModules ++ singleton ({ config, ... }: {
          home.username = config.home.user-info.username;
          home.homeDirectory = "/home/${config.home.username}";
          home.stateVersion = homeStateVersion;
          home.user-info = primaryUserDefaults // {
            nixConfigDirectory = "${config.home.homeDirectory}/.config/nixpkgs";
          };
        });
      };

      # Config with small modifications needed/desired for CI with GitHub workflow
      homeConfigurations.runner = self.homeConfigurations.annieehler.override (old: {
        modules = old.modules ++ singleton {
          home.username = mkForce "runner";
          home.homeDirectory = mkForce "/home/runner";
          home.user-info.nixConfigDirectory = mkForce "/home/runner/work/nixpkgs/nixpkgs";
        };
      });
      # }}}

    } // flake-utils.lib.eachDefaultSystem (system: {
      # Re-export `nixpkgs-unstable` with overlays.
      # This is handy in combination with setting `nix.registry.my.flake = inputs.self`.
      # Allows doing things like `nix run my#prefmanager -- watch --all`
      legacyPackages = import inputs.nixpkgs-unstable (nixpkgsDefaults // { inherit system; });

      # Development shells ----------------------------------------------------------------------{{{
      # Shell environments for development
      # With `nix.registry.my.flake = inputs.self`, development shells can be created by running,
      # e.g., `nix develop my#python`.
      devShells = let pkgs = self.legacyPackages.${system}; in
        {
          python = pkgs.mkShell {
            name = "python311";
            inputsFrom = attrValues {
              inherit (pkgs.pkgs-main.python311Packages) black isort;
              inherit (pkgs) poetry python311 pyright;
            };
          };
        };
      # }}}
    });
}
