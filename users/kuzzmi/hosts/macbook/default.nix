{ config, ... }:
let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
    overlays = [ (import ../../overlays/default.nix) ];
  };
in {
  home-manager.users.kuzzmi = { ... }: {
    home = {
      packages = with pkgs; [
        lorri
        micromamba
        # hledger
        # hledger-ui
        # wine64Packages.stable
      ];
    };
  };

  # system = {
  #   allowUnsupportedSystem = true;
  # };

  fonts.packages = [ pkgs.rubik pkgs.jetbrains-mono pkgs.nerd-fonts._0xproto ];

  launchd.user.agents = {
    "lorri" = {
      serviceConfig = {
        WorkingDirectory = (builtins.getEnv "HOME");
        EnvironmentVariables = { };
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/var/tmp/lorri.log";
        StandardErrorPath = "/var/tmp/lorri.log";
      };
      script = ''
        source ${config.system.build.setEnvironment}
        exec ${pkgs.lorri}/bin/lorri daemon
      '';
    };
  };

  # System-related settings that I would consider a user-preference
  system = {
    # Keyboard
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;

    defaults = {
      finder = {
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      NSGlobalDomain = {
        AppleInterfaceStyleSwitchesAutomatically = true;

        # InitialKeyRepeat = 1;
        # KeyRepeat = 1;
        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;
      };
      dock.autohide = true;
      dock.wvous-bl-corner = 4;
    };
  };

  # https://remotebox.knobgoblin.org.uk/downloads/RemoteBox-3.2.tar.bz2
}
