{ pkgs, config, ... }:
let
  inherit (pkgs) stdenv;
  colors = config.customization.colors;
in {
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+enter" = "";
      "cmd+enter" = "new_window_with_cwd";
      "cmd+t" = "launch --cwd=current --type=tab --location=neighbor";
      "cmd+shift+enter" = "new_window";
      "cmd+shift+t" = "launch --type=tab --location=neighbor";
    };
    settings = {
      font_family = "JetBrains Mono";
      bold_font = "JetBrains Mono ExtraBold";
      italic_font = "JetBrains Mono Italic";
      font_size = if stdenv.isLinux then 22 else 14;

      background = colors.primary.background;
      foreground = colors.primary.foreground;
      color0 = colors.normal.black;
      color1 = colors.normal.red;
      color2 = colors.normal.green;
      color3 = colors.normal.yellow;
      color4 = colors.normal.blue;
      color5 = colors.normal.magenta;
      color6 = colors.normal.cyan;
      color7 = colors.normal.white;
      color8 = colors.bright.black;
      color9 = colors.normal.red;
      color10 = colors.normal.green;
      color11 = colors.normal.yellow;
      color12 = colors.normal.blue;
      color13 = colors.normal.magenta;
      color14 = colors.normal.cyan;
      color15 = colors.normal.white;

      window_padding_width = "2 5";

      term = "xterm-256color";
      tab_bar_style = "powerline";
    };
  };
}
