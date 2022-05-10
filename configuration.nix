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
    enableIPv6 = false;
    networkmanager.enable = true;
    wireless = {
      enable = true;
      userControlled.enable = true;
      networks = {
        "Igor's iPhone" = {
          pskRaw = "73b280b4015241cf2103745269dfe4b7a2a895818a1a0d646680eaaae6c1f03d";
	};
        SLAVA_UKRAYINI = {
          pskRaw = "92834304f8d48e0e2d0e03c1510f9309eb453f378c928572704ccd785ff14de6";
	};
      };
    };
    interfaces = {
      enp5s0.useDHCP = true;
      # enp0s20f0u6c4i2.useDHCP = true;
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
    # bluetooth.enable = true;
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
      screenSection = ''
            Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
	    Option         "TripleBuffer" "on"
      '';
    };
    dbus.packages = with pkgs; [ dconf ];
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
