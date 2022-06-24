{ pkgs, config, ... }:
let
  colors = config.desktopEnvironment.colors;
  fonts = config.desktopEnvironment.fonts;
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        dynamic_title = true;
        padding = {
          x = 5;
          y = 5;
        };
        decorations = "None";
      };
      font = {
        normal = {
          family = fonts.mono.name;
          style = "Bold";
        };
        bold = {
          family = fonts.mono.name;
          style = "ExtraBold";
        };
        italic = {
          family = fonts.mono.name;
        };
        size = 16;
      };
      env.TERM = "xterm-256color";
      cursor.style = "Block";
      colors = colors;
    };
  };
}
