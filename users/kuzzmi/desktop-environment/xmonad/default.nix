{ config, ... }:
let
  colors = config.desktopEnvironment.colors;
  fonts = config.desktopEnvironment.fonts;
  cfg = builtins.toFile "config.hs" (
    builtins.replaceStrings
      [
        "{colors.background}"
        "{colors.foreground}"
        "{colors.black}"
        "{colors.red}"
        "{colors.green}"
        "{colors.yellow}"
        "{colors.blue}"
        "{colors.magenta}"
        "{colors.cyan}"
        "{colors.white}"
        "{fonts.mono.name}"
      ]
      [
        colors.primary.background
        colors.primary.foreground
        colors.normal.black
        colors.normal.red
        colors.normal.green
        colors.normal.yellow
        colors.normal.blue
        colors.normal.magenta
        colors.normal.cyan
        colors.normal.white
        fonts.mono.name
      ]
      (builtins.readFile ./xmonad.template)
    );
in
{
  xsession = {
    enable = true;
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hp: [
          hp.dbus
          hp.monad-logger
          hp.xmonad-contrib
        ];
        config = cfg;
      };
    };
  };

  home.file.".xinitrc" = {
    text = ''
      if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
        eval $(dbus-launch --exit-with-session --sh-syntax)
      fi
      systemctl --user import-environment DISPLAY XAUTHORITY

      if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
      fi

      if [ -z "$HM_XPROFILE_SOURCED" ]; then
        . "/home/kuzzmi/.xprofile"
      fi
      unset HM_XPROFILE_SOURCED

      systemctl --user start hm-graphical-session.target

      QT_QPA_PLATFORMTHEME=qt5ct
      XCURSOR_SIZE="48"
      XCURSOR_THEME="Qogir"
      xset r rate 210 40
      $HOME/.fehbg

      exec xmonad
    '';
  };
}
