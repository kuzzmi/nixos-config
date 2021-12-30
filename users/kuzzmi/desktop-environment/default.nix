{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.desktopEnvironment;
in
{
  imports = [
    ./alacritty/default.nix
    ./xmonad/default.nix
    ./rofi/default.nix
    ./polybar/default.nix
    ./dunst/default.nix
    # ./xmobar/default.nix
  ];
  options.desktopEnvironment = {
    enable = mkEnableOption "Enable desktop environment";
    theme = {
      name = mkOption {
        type = types.str;
      };
      package = mkOption {
        type = types.package;
      };
    };
    iconTheme = {
      name = mkOption {
        type = types.str;
      };
      package = mkOption {
        type = types.package;
      };
    };
    cursor = {
      name = mkOption {
        type = types.str;
      };
      size = mkOption {
        type = types.ints.positive;
      };
    };
    fonts = {
      sans = {
        name = mkOption {
          type = types.str;
        };
        size = mkOption {
          type = types.ints.positive;
        };
        package = mkOption {
          type = types.package;
        };
      };
      mono = {
        name = mkOption {
          type = types.str;
        };
        size = mkOption {
          type = types.ints.positive;
        };
        package = mkOption {
          type = types.package;
        };
      };
    };
    colors = {
      primary = {
        background = mkOption {
          type = types.str;
        };
        foreground = mkOption {
          type = types.str;
        };
      };
      normal = {
        black = mkOption {
          type = types.str;
        };
        red = mkOption {
          type = types.str;
        };
        green = mkOption {
          type = types.str;
        };
        yellow = mkOption {
          type = types.str;
        };
        blue = mkOption {
          type = types.str;
        };
        magenta = mkOption {
          type = types.str;
        };
        cyan = mkOption {
          type = types.str;
        };
        white = mkOption {
          type = types.str;
        };
      };
      bright = {
        black = mkOption {
          type = types.str;
        };
        red = mkOption {
          type = types.str;
        };
        green = mkOption {
          type = types.str;
        };
        yellow = mkOption {
          type = types.str;
        };
        blue = mkOption {
          type = types.str;
        };
        magenta = mkOption {
          type = types.str;
        };
        cyan = mkOption {
          type = types.str;
        };
        white = mkOption {
          type = types.str;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    gtk = with pkgs; {
      enable = true;
      font = {
        name = "${cfg.fonts.sans.name} ${toString cfg.fonts.sans.size}";
        package = cfg.fonts.sans.package;
      };
      theme = cfg.theme;
      iconTheme = cfg.iconTheme;
      gtk3.extraConfig = {
        gtk-cursor-theme-name = cfg.cursor.name;
        gtk-cursor-theme-size = cfg.cursor.size;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
      };
      gtk2.extraConfig = ''
        gtk-cursor-theme-name = ${cfg.cursor.name}
        gtk-cursor-theme-size = ${toString cfg.cursor.size}
      '';
    };

    # home.file.".Xresources" =
    #   {
    #     # Xcursor.theme: ${cfg.cursor.name}
    #     # Xcursor.size: ${toString cfg.cursor.size}
    #     text = with cfg.colors; ''
    #       rofi.color-enabled: true
    #       rofi.color-window: #ffffff, #ffff00, #ffffff
    #       rofi.color-normal: #ffffff, #000000, #ffffff, #ffff00, #000000
    #       rofi.color-active: #ffffff, #0000ff, #ffffff, #0000ff, #000000
    #       rofi.color-urgent: #ffffff, #ff0000, #ffffff, #ff0000, #000000
    #     '';
    #   };
    #
    home.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };
  };
}
