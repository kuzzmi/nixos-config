#!/usr/bin/python
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
