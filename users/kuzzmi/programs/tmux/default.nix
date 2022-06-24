{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    escapeTime = 0;
    baseIndex = 1;
  };

  home.file.".tmux.conf".source = ./tmux.conf;
  # home.file."${config.xdg.configHome}/tmuxinator/fin.yml".source = ./tmuxinator/fin.yml;
  home.file."${config.xdg.configHome}/tmuxinator/fundof.yml".source = ./tmuxinator/fundof.yml;
  # home.file."${config.xdg.configHome}/tmuxinator/bulleted.yml".source = ./tmuxinator/bulleted.yml;
}


