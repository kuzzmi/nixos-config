{ config, ... }:
let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
    overlays = [(import ./overlays/default.nix)];
  };

  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # You can use `ref = "nixos-<version>"` to set it here
  });

  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  };

  inherit (pkgs) stdenv;

  hm = if stdenv.isLinux then "${home-manager}/nixos" else "${home-manager}/nix-darwin";
in {
  imports = [
    "${hm}"
    ( if stdenv.isLinux
      then ./hosts/desktop/default.nix
      else ./hosts/macbook/default.nix
    )
  ];

  home-manager.users.kuzzmi = { ... }: {
    imports = [
      # nixvim.homeManagerModules.nixvim
      ./customization.nix

      # platform agnostic
      ./programs/kitty/default.nix
      ./programs/git/default.nix
      ./programs/zsh/default.nix
      ./programs/nvim/default.nix
      ./programs/ranger/default.nix
      ./programs/tmux/default.nix
    ];

    programs.home-manager.enable = true;

    customization = {
      enable = true;
      colors = {
        primary = {
          background = "#282c34";  ## A deep, dark grey, offering a modern, sleek look
          foreground = "#abb2bf";  ## A soft, light grey, for clear legibility and contrast
        };

        normal = {
          black   = "#282c34";  ## Matches the primary background for a cohesive look
          red     = "#e06c75";  ## A vibrant, warm red for attention-grabbing elements
          green   = "#98c379";  ## A fresh, lively green for success states and progress
          yellow  = "#e5c07b";  ## A warm, inviting yellow for warnings and highlights
          blue    = "#61afef";  ## A bright, calming blue for links and information
          magenta = "#c678dd";  ## A soft, playful magenta for creative elements
          cyan    = "#56b6c2";  ## A crisp, refreshing cyan for notifications and accents
          white   = "#abb2bf";  ## Matches the primary foreground for consistent readability
        };

        bright = {
          black   = "#5c6370";  ## A lighter grey for subdued text and secondary elements
          red     = "#e06c75";  ## Same as normal red, maintains vibrancy in bright context
          green   = "#98c379";  ## Same as normal green, keeps its freshness in bright areas
          yellow  = "#e5c07b";  ## Same as normal yellow, remains warm and inviting
          blue    = "#61afef";  ## Same as normal blue, keeps its clarity and calmness
          magenta = "#c678dd";  ## Same as normal magenta, retains its playful spirit
          cyan    = "#56b6c2";  ## Same as normal cyan, stays crisp and refreshing
          white   = "#ffffff";  ## A pure white for maximum contrast and highlight
        };
      };
      fonts = {
        sans = {
          name = "Rubik";
          size = 12;
          package = pkgs.rubik;
        };
        mono = {
          name = "JetBrainsMono";
          package = pkgs.jetbrains-mono;
        };
      };
    };

    home = {
      stateVersion = "23.05";

      username = "kuzzmi";

      packages = with pkgs; [
        # Utilities
        fzf
        p7zip
        direnv
        silver-searcher

        # Media
        ffmpeg
        yt-dlp

        # Finances
        hledger
      ];
    };
  };

  fonts.fontDir.enable = true;

  programs.zsh.enable = true;

>>>>>>> multi-host-refactoring
  users = {
    users.kuzzmi = {
      shell = pkgs.zsh;
      home = if stdenv.isLinux then "/home/kuzzmi" else "/Users/kuzzmi";
    };
  };
}
