{ lib, ... }:
let
  allowedUnfreePackages = [
    "cmp-snippy"
    "vim-easy-align"
    "vim-surround"
    "vim-repeat"
    "auto-pairs"
    "vim-closetag"
    "Rename"
    "vim-argumentative"
    "typescript-vim"
    "vim-javascript"
    "vim-ledger"
    "vim-abolish"
    "vim-fugitive"
  ];
  allowUnfreePredicate =
    pkg:
    let
      name = lib.getName pkg;
      pname = pkg.pname or "";
    in
    builtins.any (
      allowed: allowed == name || allowed == pname || "vimplugin-${allowed}" == name
    ) allowedUnfreePackages;
  pkgs = import <nixpkgs> {
    config.allowUnfreePredicate = allowUnfreePredicate;
    overlays = [ (import ./overlays/default.nix) ];
  };

  home-manager = fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  };

  inherit (pkgs) stdenv;

  hm = if stdenv.isLinux then "${home-manager}/nixos" else "${home-manager}/nix-darwin";
in
{
  imports = [
    "${hm}"
    (if stdenv.isLinux then ./hosts/desktop/default.nix else ./hosts/macbook/default.nix)
  ];

  home-manager.users.kuzzmi =
    { ... }:
    {
      nixpkgs.config.allowUnfreePredicate = allowUnfreePredicate;

      _module.args = {
        direnvPackage = pkgs.direnv;
      };

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
        theme = "material";
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
          bat
          p7zip
          direnv
          nixpkgs-fmt
          silver-searcher-ng
          pandoc

          # Dev
          bun
          nodejs

          # Media
          ffmpeg
          yt-dlp
          mpv

          # Finances
          hledger
        ];
      };
    };

  programs.zsh.enable = true;

  users = {
    users.kuzzmi = {
      shell = pkgs.zsh;
      home = if stdenv.isLinux then "/home/kuzzmi" else "/Users/kuzzmi";
    };
  };
}
