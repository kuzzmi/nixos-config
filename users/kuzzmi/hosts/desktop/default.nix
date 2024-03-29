{ config, ... }:
let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
    overlays = [(import ../../overlays/default.nix)];
  };
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  };
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  };
  libndi-4 = (import ./pkgs/applications/libndi-4.nix);
  iriun = (import ./pkgs/applications/iriun/default.nix);
  lwks2022 = (import ./pkgs/applications/lightworks_2022.nix);
in {
  imports = [
    "${home-manager}/nixos"
    ./nas-mounts.nix
  ];

  age = {
    identityPaths = [ /nix/persist/home/kuzzmi/.ssh/id_rsa ];
    secrets.nas.file = ../../secrets/nas.age;
  };

  home-manager.users.kuzzmi = { ... }: {
    imports = [
      "${impermanence}/home-manager.nix"

      ./services/picom/default.nix

      ./programs/xmonad/default.nix
      ./programs/rofi/default.nix
      ./programs/polybar/default.nix
      ./programs/dunst/default.nix
    ];

    customization = {
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
    };

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

    home = {
      packages = with pkgs; [
        # Browsers
        google-chrome
        tor

        # Documents and productivity
        libreoffice
        evince # PDF viewer
        joplin
        joplin-desktop
        obsidian

        # Customizations
        feh
        libnotify
        qt5ct

        # Utilities
        fzf
        pavucontrol
        unzip
        p7zip
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
        # youtube-dl
        mpv
        vlc

        # Creative
        obs-studio
        obs-studio-plugins.obs-websocket
        uxplay
        # ndi
        # libndi-4
        # obs-studio-plugins.obs-ndi
        audacity
        shotcut
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
        # ledger
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
      };

      persistence."/nix/persist/home/kuzzmi" = {
        allowOther = false;
        directories = [
          "Projects"                     # Pet and work projects
          "Pictures"                     # Wallpapers, sketches etc
          "VirtualBox VMs"               # Virtual machines
          ".arduino15"                   # To not redownload Arduino stuff
          ".audacity"                    # Audacity
          ".config/Authy Desktop"        # Authy settings
          ".config/audacity"             # Audacity
          ".config/obs-studio"           # OBS studio settings/plugins
          ".config/configstore"          # ConfigStore settings (npm package for binaries)
          ".config/google-chrome"        # Google Chrome profiles
          ".config/GIMP"                 # GIMP
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
          ".local/share/applications"    # drun shortcuts
          ".local/share/DBeaverData"     # dbeaver settings
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

          # "Videos"                                   # Local videos
          # "Android"                                  # To not redownload Android binaries every time
          # ".electrum"                                # Cryptooo
          # ".config/Android Open Source Project"      # Android Emulator
          # ".config/Google"                           # Android Studio settings
          # ".local/share/Android Open Source Project" # Android Emulator
          # ".local/share/Google"                      # Android Studio settings
        ];
        files = [
          ".fehbg"
        ];
      };
    };
  };

  services = {
    # Enables startx script with Xmonad.
    # NOTE: Can't be loaded as a part of the Home Manager.
    xserver = {
      displayManager = {
        defaultSession = "startx+xmonad";
        startx.enable = true;
      };
    };
    usbmuxd.enable = true;
    # TODO: move this to iriun derivation
    # Needed for iriun
    avahi = {
      enable = true;
    };
  };

  # Fixes keychron keyboard
  boot.extraModprobeConfig = ''
    # Function/media keys:
    #   0: Function keys only.
    #   1: Media keys by default.
    #   2: Function keys by default.
    options hid_apple fnmode=0
    # Fix tilde/backtick key.
    options hid_apple iso_layout=0
    # Swap Alt key and Command key.
    options hid_apple swap_opt_cmd=1
  '';

  users = {
    extraGroups.vboxusers.members = [ "kuzzmi" ];
    users.kuzzmi = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "dialout" "plugdev" "openrazer" "networkmanager" ];

      # Dummy password to use on initial system loading
      initialHashedPassword = "$6$86LJPxDbacGIiX2G$HlMGeEwhFD6l4N34Mj2JzDOfl6nMOfGkH9HjdQbEfXM1ruX8eZ9r7Q/K6tB5ZK6K7a67.uhSVW8fRiMZYCH64.";
    };
  };
}
