{ pkgs, ... }:

{
  home.packages = [
    pkgs.ranger
    pkgs.atool # dependency for compress/extract commands
    pkgs.highlight
  ];

  home.file.".config/ranger/rc.conf".text = ''
    map gn cd /nix/persist/etc/nixos
    map gd cd /home/kuzzmi/Downloads
    map gp cd /home/kuzzmi/Projects
    map gH cd /nix/persist/home/kuzzmi

    set use_preview_script true
  '';

  home.file.".config/ranger/commands.py".source = ./commands.py;
}

