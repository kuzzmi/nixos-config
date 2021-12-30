{ pkgs, ... }:
{
  programs.xmobar = {
    enable = true;
  };
  home.file.".xmonad/xmobar.conf".text = ''
    Config
        { font              = "xft:JetBrainsMono:weight=900:pixelsize=26:antialias=true:hinting=true"
        , additionalFonts   = [ "xft:FontAwesome:pixelsize=24:antialias=true:hinting=true" ]
        , allDesktops       = True
        , bgColor           = "#2d2d2d"
        , fgColor           = "#464646"
        , alpha             = 230
        , overrideRedirect  = True
        , commands          = [
            Run Cpu
                [ "-t", "<vbar>"
                , "-L", "40"
                , "-H", "60"
                , "-l", "#99cc99"
                , "-h", "#f2777a"
                ] 10
            , Run Memory
                [ "-t", "<usedvbar>"
                , "-p", "2"
                , "-l", "#99cc99"
                , "-h", "#f2777a"
                ] 10
            , Run Kbd
                [ ("us(colemak)" , "<fc=#99cc99>US</fc>")
                , ("ua(winkeys)" , "<fc=#cc99cc>UA</fc>")
                , ("ru(winkeys)" , "<fc=#66cccc>RU</fc>")
                ]
            , Run Date "%a <fc=#838383>%_d %b</fc> %Y <fc=#838383>%H:%M</fc>:%S" "date" 10
            , Run CommandReader "${pkgs.writeScript "volume" ''
#!${pkgs.python3}/bin/python
# -*- coding: utf8 -*-

import sys
import time
import os

allbars =   "[--------]"
emptybars = "[        ]"

home = os.getenv("HOME")

with open(home + "/.volume") as f:
  content = f.readlines()

with open(home + "/.mute") as f:
  isunmuted = (int(f.readlines()[0]) == 0)

if isunmuted:
  maxvol = 65536
  volume = int(content[0])
  maxbars = 8
  step = int(maxvol / maxbars)
  bars = int(volume / step)

  # print(volume, step, bars)

  output = allbars[0:bars] + '|' + emptybars[bars+1:]
  if (volume == 0):
    output = "[        ]"
else:
  output = "[  mute  ]"

print(output)
sys.stdout.flush
	    ''}" "vol"

	    -- "${pkgs.python3}/bin/python3" ["/home/kuzzmi/.xmonad/xmonad-pulsevolume/show-volume.py"] "vol" 1
            , Run Com "${pkgs.bash}/bin/bash" ["-c", "cat /tmp/weather | cut -d'.' -f1"] "weather" 1
            , Run Com "${pkgs.bash}/bin/bash" ["/home/kuzzmi/.local/bin/vpn-status.sh"] "vpn" 1
            , Run Com "${pkgs.bash}/bin/bash" ["-c", "cat /home/kuzzmi/.local/.office-ac"] "ac" 1
            , Run Com "${pkgs.bash}/bin/bash" ["-c", "mosquitto_sub -h 192.168.88.132 -t 'SLS/Weather at Home Office' -C 1 | jq .temperature | cut -d'.' -f1"] "office-temp" 300
            , Run StdinReader
            ]
            , sepChar       = "%"
            , alignSep      = "}{"
            , template      = " %StdinReader% } { <action=~/.local/bin/toggle-ac.sh>AC %ac%</action>  <fc=#838383>%office-temp%°C</fc>/<fc=#838383>%weather%°C</fc>  %vpn%  <fc=#838383>%vol%</fc> %cpu%%memory%  %kbd%  %date% "
        }
  '';
}
