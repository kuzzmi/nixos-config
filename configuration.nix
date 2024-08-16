{ config, pkgs, ... }:

let
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  };
in {
  imports =
    [
      "${impermanence}/nixos.nix"
      ./common-configuration.nix
      ./hardware-configuration.nix
    ];

  networking = {
    useDHCP = true;
    enableIPv6 = false;
    networkmanager.enable = false;
    wireless = {
      enable = false;
      userControlled.enable = true;
      networks = {
        SLAVA_UKRAYINI = {
          pskRaw = "92834304f8d48e0e2d0e03c1510f9309eb453f378c928572704ccd785ff14de6";
        };
      };
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 5001 3000 9999 5960 5961 5962 7053 7054 11223 5201
	3389
	18083 # vboxwebsrv
      ];
      allowedUDPPorts = [ 8554 ];
    };
    interfaces = {
      enp5s0.useDHCP = true;
      wlo1.useDHCP = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
    };
    virtualbox.host = {
      enable = false;
      enableExtensionPack = true;
      enableWebService = true;
      headless = true;
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

  # sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    nvidia-container-toolkit.enable = true;
  };

  users.mutableUsers = false;

  services = {
    # pipewire = {
    #   enable = true;
    #   pulse.enable = true;
    # };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      screenSection = ''
            Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
	    Option         "TripleBuffer" "on"
      '';
    };
    libinput = {
      enable = true;

      # disabling mouse acceleration
      mouse = {
        accelProfile = "flat";
      };
    };
    dbus.packages = with pkgs; [ dconf ];
    gnome.gnome-keyring.enable = true;
    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };
  };

  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/var/log"
        "/var/lib/docker"
        "/var/lib/plex"
        "/var/db/sudo"
        "/etc/nixos"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
    etc = {
      "ssh/ssh_host_rsa_key".source =
        "/nix/persist/etc/ssh/ssh_host_rsa_key";
      "ssh/ssh_host_rsa_key.pub".source =
        "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
      "ssh/ssh_host_ed25519_key".source =
        "/nix/persist/etc/ssh/ssh_host_ed25519_key";
      "ssh/ssh_host_ed25519_key.pub".source =
        "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
    };
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    mosh.enable = true;
  };

  nix = {
    gc = {
      dates = "weekly";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  system.stateVersion = "23.11";
}
