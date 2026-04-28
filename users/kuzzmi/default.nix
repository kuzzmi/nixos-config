{ ... }:
let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
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
          silver-searcher
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
