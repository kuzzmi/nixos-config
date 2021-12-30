{ config, pkgs, ... }:

let
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  };
  agenix = builtins.fetchTarball {
    url = "https://github.com/ryantm/agenix/archive/main.tar.gz";
  };
in {
  imports =
    [
      "${impermanence}/nixos.nix"
      "${agenix}/modules/age.nix"
      ./hardware-configuration.nix
      ./users/kuzzmi/default.nix
    ];

  networking = {
    useDHCP = false;
    interfaces = {
      enp5s0.useDHCP = true;
      wlo1.useDHCP = true;
    };
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Europe/Kiev";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "colemak";
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    openrazer.enable = true;
  };

  users.mutableUsers = false;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-9.4.4"
    ];
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };
    dbus.packages = [ pkgs.gnome3.dconf ];
    gnome.gnome-keyring.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      ranger
      (pkgs.callPackage "${agenix}/pkgs/agenix.nix" {})
    ];

    persistence."/nix/persist" = {
      directories = [
        "/var/log"
        "/var/db/sudo"
        "/etc/nixos"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };

  programs.steam.enable = true;

  system.stateVersion = "21.05";
}
