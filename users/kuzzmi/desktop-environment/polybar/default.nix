{ pkgs, config, ... }:
let
  colors = config.desktopEnvironment.colors;
  fonts = config.desktopEnvironment.fonts;

  foreground = colors.bright.white;
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      pulseSupport = true;
    };
    settings = {
      "bar/base" = {
        monitor-fallback = "";
        monitor-strict = false;
        override-redirect = false;
        bottom = false;
        fixed-center = true;
        # width = "100%";
        height = 60;
        # radius = 14;
        # offset-y = 20;
        background = colors.primary.background;
        foreground = colors.primary.foreground;
        dim-value = 1;
        font = {
          "0" = "${fonts.mono.name}:weight:900:pixelsize=20:bold:antialias=true:hinting=true;3";
        };
        tray.position = "none";
      };
      "bar/main" = {
        "inherit" = "bar/base";
        modules = {
          left = "xmonad";
          center = "title";
          right = "cpu memory keyboard date";
        };
      };
      "bar/left" = {
        "inherit" = "bar/base";
        modules = {
          left = "xmonad";
        };
        width = 700;
        offset-x = 20;
      };
      "bar/layout" = {
        width = 100;
        enable-ipc = true;
        offset-x = 486;
        modules = {
          left = "xmonad";
        };
      };
      "bar/center" = {
        "inherit" = "bar/base";
        enable-ipc = true;
        modules = {
          center = "title";
        };
        width = "30%";
        offset-x = 1280;
      };
      "bar/right" = {
        "inherit" = "bar/base";
        modules = {
          right = "cpu memory keyboard date";
        };
        width = "18%";
        offset-x = 3130;
      };
      "global/wm" = {
        margin.bottom = 0;
        margin.top = 0;
      };
      "settings" = {
        throttle-output = 5;
        throttle-output-for = 10;
        screenchange.reload = false;
        # https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-operator-t
        compositing.background = "source";
        compositing.foreground = "over";
        compositing.overline = "over";
        compositing.underline = "over";
        compositing.border = "over";
      };
      "module/title" = {
        type = "internal/xwindow";
        format.text = "<label>";
        format.padding = 2;
        label-maxlen = 64;
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 1;
        format.text = "<label>";
        format.padding = 2;
        label = "%percentage%%";
      };
      "module/date" = {
        type = "internal/date";
        interval = 1;
        time = "%a %d %b %H:%M:%S";
        format.text = "<label>";
        format.padding = 2;
        label = "%time%";
      };
      "module/memory" = {
        type = "internal/memory";
        interval = 1;
        format.padding = 2;
        label = "%percentage_used%%";
      };
      "module/keyboard" = {
        type = "internal/xkeyboard";
        blacklist = {
          "0" = "num lock";
          "1" = "scroll lock";
        };
        format.text = "<label-layout>";
        format.padding = 2;
        label.layout.text = "%layout%";
      };
      "module/xmonad" = {
        type = "custom/script";
        exec = "${pkgs.xmonad-log}/bin/xmonad-log";
        tail = true;
        format = {
          padding = 2;
        };
      };
      "module/workspaces" = {
        type = "internal/xworkspaces";
      };
    };
    script = "polybar left & disown; polybar right & disown; polybar center & disown";
  };
}
