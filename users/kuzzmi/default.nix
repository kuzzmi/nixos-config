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
  rubik = (import ./pkgs/fonts/rubik.nix);
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
      ./programs/tmux/default.nix
      ./programs/git/default.nix
      ./programs/zsh/default.nix
      ./programs/nvim/default.nix
      ./programs/gpg/default.nix
      ./programs/ranger/default.nix
      # ./services/redshift/default.nix
      ./services/picom/default.nix
    ];

    services.gnome-keyring.enable = true;
    services.gpg-agent.enable = true;
    services.lorri.enable = true;
    programs.home-manager.enable = true;

    desktopEnvironment = {
      enable = true;
      colors = {
        # primary = {
        #   background = "#2D2D2D";
        #   foreground = "#D3D0C8";
        # };
        # normal = {
        #   black   = "#2D2D2D";
        #   red     = "#F2777A";
        #   green   = "#99CC99";
        #   yellow  = "#FFCC66";
        #   blue    = "#6699CC";
        #   magenta = "#CC99CC";
        #   cyan    = "#66CCCC";
        #   white   = "#D3D0C8";
        # };
        # bright = {
        #   black   = "#747369";
        #   red     = "#F2777A";
        #   green   = "#99CC99";
        #   yellow  = "#FFCC66";
        #   blue    = "#6699CC";
        #   magenta = "#CC99CC";
        #   cyan    = "#66CCCC";
        #   white   = "#FFFFFF";
        # };
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
          name = "Open Sans";
          size = 12;
          package = pkgs.open-sans;
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
        gphoto2 # To capture LiveView from camera
        dconf
        xclip
        xorg.xev
        libusb

        # To talk to iPhone
        libimobiledevice
        ifuse

        # Media
        ffmpeg
        playerctl
        youtube-dl
        mpv
        vlc
        streamlink

        # Creative
        obs-studio
        audacity
        ocenaudio
        lwks2022
        gimp
        inkscape

        # Security
        keepassxc
        libsecret
        gnome.seahorse
        # authy
        openvpn

        # Crypto
        electrum
        # ethminer

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
        calibre
        lutris

        # Screen shots / screen recordings
        flameshot
        simplescreenrecorder

        # Fonts
        jetbrains-mono
        font-awesome
        material-design-icons
        rubik
        roboto

        # Fin
        ledger
        fava
        gnuplot_qt

        # Dev
        gh
        gnumake
        dbeaver
        google-cloud-sdk
        android-studio
        docker-compose
        postman
        arduino-cli
        jdk
        mosquitto
      ];

      keyboard = {
        model = "pc105";
        layout = "us,ua,ru";
        variant = "colemak,winkeys,winkeys";
        options = [ "grp:shifts_toggle" ];
        # options = [ "grp:shifts_toggle" "caps:escape" ];
      };

      persistence."/nix/persist/home/kuzzmi" = {
        allowOther = false;
        directories = [
          "Projects"                     # Pet and work projects
          "Pictures"                     # Wallpapers, sketches etc
          "Videos"                       # Local videos
          "VirtualBox VMs"               # Virtual machines
          "Android"                      # To not redownload Android binaries every time
          ".arduino15"                   # To not redownload Arduino stuff
          ".electrum"                    # Cryptooo
          ".audacity"                    # Audacity
          ".cache/ocenaudio"             # Ocenaudio temp cache
          ".config/Android Open Source Project" # Android Emulator
          ".config/Authy Desktop"        # Authy settings
          ".config/audacity"             # Audacity
          ".config/configstore"          # ConfigStore settings (npm package for binaries)
          ".config/Google"               # Android Studio settings
          ".config/google-chrome"        # Google Chrome profiles
          ".config/keepassxc"            # TODO: Settings for KeePassXC, not working
          ".config/Slack"                # Slack stuff
          # ".config/yarn"                 # yarn binaries
          ".config/mpv"                  # mpv config
          ".config/zsh"                  # Zsh history
          ".config/Mailspring"           # Email
          ".config/qt5ct"                # TODO: QT5 theming, not working
          ".config/pulse"                # PulseAudio settings
          ".config/Postman"              # Postman settings
          ".config/nextjs-nodejs"        # NextJS settings
          ".local/share/Android Open Source Project" # Android Emulator
          ".local/share/applications"    # drun shortcuts
          ".local/share/DBeaverData"     # dbeaver settings
          ".local/share/Google"          # Android Studio settings
          ".local/share/keyrings"        # security keyrings
          ".local/share/ranger"          # ranger stuff
          ".local/share/TelegramDesktop" # Telegram settings
          ".local/share/vlc"             # VLC settings
          ".local/share/direnv"          # direnv permission directory
          ".local/data/pgsql"            # postgresql data
          ".ssh"
          ".ntcardvt-wrapped"            # lightworks settings
          ".local/share/Meltytech/Shotcut/" # Shotcut settings
          # ".yarn"

          # Steam
          # ".steam"
          ".local/share/Steam"
          ".factorio"
        ];
        files = [
          ".fehbg"
        ];
      };

      file.".xbindkeysrc".text = ''
        "xdotool key Escape && sleep 0.5 && xdotool mousemove 1913 941 && xdotool click 1 && sleep 2 && xdotool key Return"
          Scroll_Lock
      '';

      file.".config/streamlink/config".text = ''
        # Player options
        player=mpv --cache 2048
        player-no-close
      '';
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["google-chrome.desktop"];
        "application/pdf" = ["evince.desktop"];
        "inode/directory" = ["ranger.desktop"];
        "application/x-directory" = ["ranger.desktop"];
      };
    };

    services.xcape = {
      enable = true;
      timeout = 250;
      mapExpression = {
        Super_L = "Escape";
      };
    };
  };

  # Enables startx script with Xmonad.
  # NOTE: Can't be loaded as a part of the Home Manager.
  services.xserver.displayManager = {
    defaultSession = "startx+xmonad";
    startx.enable = true;
  };

  services.usbmuxd.enable = true;

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
