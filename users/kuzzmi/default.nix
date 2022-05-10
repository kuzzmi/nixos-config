{ config, ... }:
let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
    overlays = [(import ./overlays/default.nix)];
  };
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  };
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  };
  iriun = (import ./pkgs/applications/iriun/default.nix);
  lwks2022 = (import ./pkgs/applications/lightworks_2022.nix);
in {
  age = {
    identityPaths = [ /nix/persist/home/kuzzmi/.ssh/id_rsa ];
    secrets.nas.file = ./secrets/nas.age;
  };

  imports = [
    "${home-manager}/nixos"
    ./nas-mounts.nix
  ];

  home-manager.users.kuzzmi = { ... }: {
    imports = [
      "${impermanence}/home-manager.nix"
      ./desktop-environment/default.nix
      ./programs/git/default.nix
      ./programs/zsh/default.nix
      ./programs/nvim/default.nix
      ./programs/ranger/default.nix
      ./services/picom/default.nix
      # ./programs/tmux/default.nix
      # ./programs/gpg/default.nix
      # ./services/redshift/default.nix
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

    programs.home-manager.enable = true;

    desktopEnvironment = {
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
      theme = {
        name = "Qogir-light";
        package = pkgs.qogir-theme;
      };
      iconTheme = {
        package = pkgs.qogir-icon-theme;
        name = "Qogir-dark";
      };
      cursor = {
        name = "Qogir";
        size = 48;
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
      username = "kuzzmi";

      packages = with pkgs; [
        # Browsers
        google-chrome
        tor

        # Customizations
        feh
        libnotify
        qt5ct

        # Utilities
        git
        silver-searcher
        fzf
        pavucontrol
        unzip
        entr    # monitor changes
        direnv  # directory-specific envs
        xbindkeys
        xdotool
        yq
        udisks
        bashmount
        dconf
        xclip
        xorg.xev
        libusb
        blueman
        gparted
        cryptsetup # work with luks
        rclone     # to mount folders from pCloud

        # iOS as a webcam
        iriun

        # To talk to iPhone
        libimobiledevice
        ifuse

        # Media
        ffmpeg
        playerctl
        youtube-dl
        mpv
        vlc

        # Creative
        obs-studio
        audacity
        lwks2022
        gimp
        inkscape

        # Security
        keepassxc
        libsecret
        gnome.seahorse
        openvpn

        # Crypto
        # electrum

        # Commmunication
        skypeforlinux
        slack
        zoom-us
        tdesktop
        mailspring

        # Misc
        libreoffice
        evince # PDF viewer
        transmission
        razergenie
        # calibre # ebook manager
        lutris # games installer

        # Screen shots / screen recordings
        flameshot
        simplescreenrecorder

        # Fonts
        jetbrains-mono
        font-awesome
        material-design-icons
        rubik
        roboto
        paratype-pt-sans

        # Fin
        ledger
        fava
        gnuplot_qt

        # Dev
        gh
        gnumake
        dbeaver
        google-cloud-sdk
        # android-studio
        docker-compose
        postman
        arduino-cli
        jdk
        mosquitto
      ];

      keyboard = {
        model = "pc105";
        layout = "us,ua";
        variant = "colemak,winkeys";
        options = [ "grp:shifts_toggle" "caps:escape" ];
        # options = [ "grp:shifts_toggle" ];
      };

      persistence."/nix/persist/home/kuzzmi" = {
        allowOther = false;
        directories = [
          "Projects"                     # Pet and work projects
          "Pictures"                     # Wallpapers, sketches etc
          "Videos"                       # Local videos
          "VirtualBox VMs"               # Virtual machines
          # "Android"                      # To not redownload Android binaries every time
          ".arduino15"                   # To not redownload Arduino stuff
          # ".electrum"                    # Cryptooo
          ".audacity"                    # Audacity
          # ".config/Android Open Source Project" # Android Emulator
          ".config/Authy Desktop"        # Authy settings
          ".config/audacity"             # Audacity
          ".config/obs-studio"           # OBS studio settings/plugins
          ".config/configstore"          # ConfigStore settings (npm package for binaries)
          # ".config/Google"               # Android Studio settings
          ".config/google-chrome"        # Google Chrome profiles
          ".config/keepassxc"            # TODO: Settings for KeePassXC, not working
          ".config/Slack"                # Slack stuff
          ".config/mpv"                  # mpv config
          ".config/zsh"                  # Zsh history
          ".config/Mailspring"           # Email
          ".config/qt5ct"                # TODO: QT5 theming, not working
          ".config/pulse"                # PulseAudio settings
          ".config/Postman"              # Postman settings
          ".config/nextjs-nodejs"        # NextJS settings
          ".config/rclone"               # rclone settings
          # ".local/share/Android Open Source Project" # Android Emulator
          ".local/share/applications"    # drun shortcuts
          ".local/share/DBeaverData"     # dbeaver settings
          # ".local/share/Google"          # Android Studio settings
          ".local/share/keyrings"        # security keyrings
          ".local/share/ranger"          # ranger stuff
          ".local/share/TelegramDesktop" # Telegram settings
          ".local/share/vlc"             # VLC settings
          ".local/share/direnv"          # direnv permission directory
          ".local/data/pgsql"            # postgresql data
          ".ssh"
          ".ntcardvt-wrapped"            # lightworks settings

          # Steam
          ".local/share/Steam"
          ".factorio"
        ];
        files = [
          ".fehbg"
        ];
      };
    };
  };

  systemd.services.keychron-params = {
    enable = true;
    description = "The command to make the Keychron K12 work correctly";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c \"echo 0 > /sys/module/hid_apple/parameters/fnmode\" && /bin/sh -c \"echo 1 > /sys/module/hid_apple/parameters/swap_opt_cmd\"";
    };
    wantedBy = [ "default.target" ];
  };

  services = {
    # Enables startx script with Xmonad.
    # NOTE: Can't be loaded as a part of the Home Manager.
    xserver.displayManager = {
      defaultSession = "startx+xmonad";
      startx.enable = true;
    };
    usbmuxd.enable = true;
    # TODO: move this to iriun derivation
    # Needed for iriun
    avahi = {
      enable = true;
    };
  };

  users = {
    extraGroups.vboxusers.members = [ "kuzzmi" ];
    users.kuzzmi = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "dialout" "plugdev" "openrazer" ];
      shell = pkgs.zsh;

      # Dummy password to use on initial system loading
      initialHashedPassword = "$6$86LJPxDbacGIiX2G$HlMGeEwhFD6l4N34Mj2JzDOfl6nMOfGkH9HjdQbEfXM1ruX8eZ9r7Q/K6tB5ZK6K7a67.uhSVW8fRiMZYCH64.";
    };
  };
}
