{ config, ... }:
let
  colors = config.customization.colors;
  fonts = config.customization.fonts;
in
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        geometry = "600x50-50+65";
        shrink = "yes";
        # transparency = 20;
        progress_bar = true;
        padding = 30;
        horizontal_padding = 34;
        # corner_radius = 6;
        font = "${fonts.mono.name} 10";
        line_height = 4;
        format = ''<b>%s</b>\n%b'';
      };
      urgency_low = {
        background = colors.primary.background;
        foreground = colors.bright.white;
      };
      urgency_normal = {
        background = "#FFFFFF";
        foreground = colors.primary.background;
      };
      urgency_critical = {
        background = colors.normal.red;
        foreground = "#FFFFFF";
      };
    };
  };
}
