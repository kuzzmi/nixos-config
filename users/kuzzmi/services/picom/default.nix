{ pkgs, ... }:
let
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };
in {
  services.picom = {
    enable = true;
    package = nur.repos.reedrw.picom-next-ibhagwan;
    # backend = "xrender";
    backend = "glx";
    # vSync = true;

    # fading = true;
    # fade-in-step = 0.1;
    # fade-out-step = 0.1;
        # "window_type = 'desktop'",

    extraOptions = ''
      corner-radius = 14;
      rounded-corners-exclude = [
        "class_g ?= 'Polybar'",
        "class_g ?= 'Steam'"
      ];
      shadow = true;
      shadow-offset-x = -30;
      shadow-offset-y = -30;
      shadow-radius = 30;
      shadow-opacity = .3;
      transparent-clipping = false;
      focus-exclude = [
        "window_type = 'dock'",
        "window_type = 'desktop'",
      ];
      shadow-exclude = [
        "name = 'Notification'",
        "class_g = 'Conky'",
        "class_g ?= 'Notify-osd'",
        "class_g = 'Cairo-clock'",
        "_GTK_FRAME_EXTENTS@:c",
        "class_g ?= 'Steam'"
      ];
    '';
  };
}
