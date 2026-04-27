{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.customization;
  inherit (pkgs) stdenv;
  themes = {
    material = {
      primary = {
        background = "#263238";
        foreground = "#eceff1";
      };
      normal = {
        black = "#263238";
        red = "#ff9800";
        green = "#8bc34a";
        yellow = "#ffc107";
        blue = "#03a9f4";
        magenta = "#e91e63";
        cyan = "#009688";
        white = "#cfd8dc";
      };
      bright = {
        black = "#37474f";
        red = "#ffa74d";
        green = "#9ccc65";
        yellow = "#ffa000";
        blue = "#81d4fa";
        magenta = "#ad1457";
        cyan = "#26a69a";
        white = "#eceff1";
      };
    };
    onedark = {
      primary = {
        background = "#282c34";
        foreground = "#abb2bf";
      };
      normal = {
        black = "#282c34";
        red = "#e06c75";
        green = "#98c379";
        yellow = "#e5c07b";
        blue = "#61afef";
        magenta = "#c678dd";
        cyan = "#56b6c2";
        white = "#abb2bf";
      };
      bright = {
        black = "#5c6370";
        red = "#e06c75";
        green = "#98c379";
        yellow = "#e5c07b";
        blue = "#61afef";
        magenta = "#c678dd";
        cyan = "#56b6c2";
        white = "#ffffff";
      };
    };
    monokai = {
      primary = {
        background = "#272822";
        foreground = "#f1ebeb";
      };
      normal = {
        black = "#48483e";
        red = "#dc2566";
        green = "#8fc029";
        yellow = "#d4c96e";
        blue = "#55bcce";
        magenta = "#9358fe";
        cyan = "#56b7a5";
        white = "#acada1";
      };
      bright = {
        black = "#76715e";
        red = "#fa2772";
        green = "#a7e22e";
        yellow = "#e7db75";
        blue = "#66d9ee";
        magenta = "#ae82ff";
        cyan = "#66efd5";
        white = "#cfd0c2";
      };
    };
    visibone-2 = {
      primary = {
        background = "#333333";
        foreground = "#cccccc";
      };
      normal = {
        black = "#666666";
        red = "#cc6699";
        green = "#99cc66";
        yellow = "#cc9966";
        blue = "#6699cc";
        magenta = "#9966cc";
        cyan = "#66cc99";
        white = "#cccccc";
      };
      bright = {
        black = "#999999";
        red = "#ff99cc";
        green = "#ccff99";
        yellow = "#ffcc99";
        blue = "#99ccff";
        magenta = "#cc99ff";
        cyan = "#99ffcc";
        white = "#ffffff";
      };
    };
  };
in {
  options.customization = {
    enable = mkEnableOption "Enable color customization";
    theme = mkOption {
      type = types.enum (builtins.attrNames themes);
      description = "Theme to use for colors";
    };
    themePkg = {
      name = mkOption { type = types.str; };
      package = mkOption { type = types.package; };
    };
    iconThemePkg = {
      name = mkOption { type = types.str; };
      package = mkOption { type = types.package; };
    };
    cursor = {
      name = mkOption { type = types.str; };
      size = mkOption { type = types.ints.positive; };
    };
    fonts = {
      sans = {
        name = mkOption { type = types.str; };
        size = mkOption { type = types.ints.positive; };
        package = mkOption { type = types.package; };
      };
      mono = {
        name = mkOption { type = types.str; };
        size = mkOption { type = types.ints.positive; };
        package = mkOption { type = types.package; };
      };
    };
    # Define colors as a computed option with proper structure
    colors = {
      primary = {
        background = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.primary.background;
        };
        foreground = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.primary.foreground;
        };
      };
      normal = {
        black = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.normal.black;
        };
        red = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.normal.red;
        };
        green = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.normal.green;
        };
        yellow = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.normal.yellow;
        };
        blue = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.normal.blue;
        };
        magenta = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.normal.magenta;
        };
        cyan = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.normal.cyan;
        };
        white = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.normal.white;
        };
      };
      bright = {
        black = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.bright.black;
        };
        red = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.bright.red;
        };
        green = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.bright.green;
        };
        yellow = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.bright.yellow;
        };
        blue = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.bright.blue;
        };
        magenta = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.bright.magenta;
        };
        cyan = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.bright.cyan;
        };
        white = mkOption {
          type = types.str;
          default = themes.${cfg.theme}.bright.white;
        };
      };
    };
    # colors = {
    #   primary = {
    #     background = mkOption { type = types.str; };
    #     foreground = mkOption { type = types.str; };
    #   };
    #   normal = {
    #     black = mkOption { type = types.str; };
    #     red = mkOption { type = types.str; };
    #     green = mkOption { type = types.str; };
    #     yellow = mkOption { type = types.str; };
    #     blue = mkOption { type = types.str; };
    #     magenta = mkOption { type = types.str; };
    #     cyan = mkOption { type = types.str; };
    #     white = mkOption { type = types.str; };
    #   };
    #   bright = {
    #     black = mkOption { type = types.str; };
    #     red = mkOption { type = types.str; };
    #     green = mkOption { type = types.str; };
    #     yellow = mkOption { type = types.str; };
    #     blue = mkOption { type = types.str; };
    #     magenta = mkOption { type = types.str; };
    #     cyan = mkOption { type = types.str; };
    #     white = mkOption { type = types.str; };
    #   };
    # };
  };

  config = mkIf (all (x: x == true) [ cfg.enable stdenv.isLinux ]) {
    gtk = {
      enable = true;
      font = {
        name = "${cfg.fonts.sans.name} ${toString cfg.fonts.sans.size}";
        package = cfg.fonts.sans.package;
      };
      theme = cfg.themePkg;
      iconTheme = cfg.iconThemePkg;
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

    home.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
  };
}
