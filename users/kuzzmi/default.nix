{ config, ... }:
let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
    overlays = [(import ./overlays/default.nix)];
  };

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
          background = "#1d1f21";
          foreground = "#c5c8c6";
        };
        normal = {
          black   = "#1d1f21";
          red     = "#cc6666";
          green   = "#b5bd68";
          yellow  = "#f0c674";
          blue    = "#81a2be";
          magenta = "#b294bb";
          cyan    = "#8abeb7";
          white   = "#c5c8c6";
        };
        bright = {
          black   = "#969896";
          red     = "#cc6666";
          green   = "#b5bd68";
          yellow  = "#f0c674";
          blue    = "#81a2be";
          magenta = "#b294bb";
          cyan    = "#8abeb7";
          white   = "#c5c8c6";
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

  users = {
    users.kuzzmi = {
      shell = pkgs.zsh;
      home = if stdenv.isLinux then "/home/kuzzmi" else "/Users/kuzzmi";
    };
  };
}
