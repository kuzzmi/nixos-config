{ config, ... }:
let
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  };
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  };
in {
  imports = [
    "${home-manager}/nixos"
    ./nas-mounts.nix
  ];

  home-manager.users.kuzzmi = { ... }: {
    imports = [
      "${impermanence}/home-manager.nix"
      ./customization.nix

      ./services/picom/default.nix

      ./kitty/default.nix
      ./xmonad/default.nix
      ./rofi/default.nix
      ./polybar/default.nix
      ./dunst/default.nix

      # platform agnostic
      ./programs/git/default.nix
      ./programs/zsh/default.nix
      ./programs/nvim/default.nix
      ./programs/ranger/default.nix
      ./programs/tmux/default.nix
    ];

    services = {
      gnome-keyring.enable = true;
      gpg-agent.enable = true;
      lorri.enable = true;
      xcape = {
        enable = true;
        timeout = 250;
        mapExpression = {
          Super_L = "Escape";
          Escape = "~";
        };
      };
    };

  };
}
