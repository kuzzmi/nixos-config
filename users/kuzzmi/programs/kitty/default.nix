{ pkgs, config, ... }:
let
  colors = config.customization.colors;
  fonts = config.customization.fonts;
in
{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrains Mono Bold";
      bold_font   = "JetBrains Mono ExtraBold";
      italic_font = "JetBrains Mono Italic";
      font_size   = 22;

      background  = colors.primary.background;
      foreground  = colors.primary.foreground;
      color0      = colors.normal.black;
      color1      = colors.normal.red;
      color2      = colors.normal.green;
      color3      = colors.normal.yellow;
      color4      = colors.normal.blue;
      color5      = colors.normal.magenta;
      color6      = colors.normal.cyan;
      color7      = colors.normal.white;
      color8      = colors.bright.black;
      color9      = colors.normal.red;
      color10     = colors.normal.green;
      color11     = colors.normal.yellow;
      color12     = colors.normal.blue;
      color13     = colors.normal.magenta;
      color14     = colors.normal.cyan;
      color15     = colors.normal.white;

      window_padding_width = "2 5";
    };
  };
}
