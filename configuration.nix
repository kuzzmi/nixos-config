{ config, pkgs, ... }:

let
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  };
in {
  imports =
    [
      "${impermanence}/nixos.nix"
      "${agenix}/modules/age.nix"
      ./common-configuration.nix
      ./hardware-configuration.nix
    ];

  networking = {
    useDHCP = false;
    enableIPv6 = false;
    wireless = {
      enable = true;
      userControlled.enable = true;
      networks = {
        SLAVA_UKRAYINI = {
          pskRaw = "92834304f8d48e0e2d0e03c1510f9309eb453f378c928572704ccd785ff14de6";
	};
      };
    };
    firewall.allowedTCPPorts = [ 22 5000 3000 ];
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

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "colemak";
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    openrazer.enable = true;
    bluetooth.enable = true;
  };

  users.mutableUsers = false;

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      screenSection = ''
            Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
	    Option         "TripleBuffer" "on"
      '';
    };
    dbus.packages = with pkgs; [ dconf ];
    gnome.gnome-keyring.enable = true;
    openssh = {
      enable = true;
    };
  };

  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/var/log"
        "/var/lib/docker"
        "/var/db/sudo"
        "/etc/nixos"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };

  programs = {
    steam.enable = true;
    mosh.enable = true;
  };


  system.stateVersion = "21.05";
}
