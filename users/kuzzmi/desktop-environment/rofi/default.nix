{ pkgs, config, ... }:
let
  fonts = config.desktopEnvironment.fonts;
  colors = config.desktopEnvironment.colors;
  icons = config.desktopEnvironment.iconTheme.name;
in
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    extraConfig = {
      modi = "combi";
      width = 40;
      lines = 10;
      columns = 1;
      font = "${fonts.mono.name} Bold 26";
      bw = 0;
      location = 0;
      padding = 40;
      terminal = "alacritty";
      run-shell-command = "{terminal} -e {cmd}";
      case-sensitive = false;
      combi-modi = "window,run,drun";
      line-margin = 8;
      line-padding = 8;
      separator-style = "none";
      hide-scrollbar = true;
      scrollbar-width = 8;
      color-enabled = true;
      kb-mode-next = "Tab";
      kb-mode-previous = "Shift+Tab";
      kb-row-up = "Up,Control+p";
      kb-row-tab = "Control+Tab";
    };
    theme = builtins.toFile "theme.rasi" (
      builtins.replaceStrings
      [
        "{bg}"
        "{fg}"
        "{transparent}"
        "{normal}"
        "{active}"
        "{urgent}"
      ]
      [
        "#FFFFFFFF"
        colors.primary.background
        "#00000000"
        colors.normal.yellow
        colors.normal.blue
        colors.normal.red
      ]
      (builtins.readFile ./theme.rasi)
    );
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
    ];
  };
}
