#!/bin/sh
set -eu

prompt="${1:-Please enter macOS password to run sudo.}"

SUDO_ASKPASS_PROMPT="$prompt" /usr/bin/osascript <<'APPLESCRIPT'
set promptText to system attribute "SUDO_ASKPASS_PROMPT"
if promptText is "" then set promptText to "Please enter your macOS password to run sudo."
display dialog promptText default answer "" with hidden answer buttons {"Cancel", "OK"} default button "OK"
text returned of result
APPLESCRIPT
