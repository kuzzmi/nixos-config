{ config, pkgs, ... }:
{
  home-manager.users.kuzzmi = { ... }: {
    home = {
      packages = with pkgs; [
        lorri
        # hledger
        # hledger-ui
      ];
    };
  };

  # System-related settings that I would consider a user-preference
  system = {
    # Keyboard
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;

    defaults = {
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
}
