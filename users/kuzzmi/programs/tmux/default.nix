{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    escapeTime = 0;
    baseIndex = 1;
  };

  home.file.".tmux.conf".source = ./tmux.conf;
}


