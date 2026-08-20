{ pkgs, ... }:

{
  imports = [ ./common-configuration.nix ];

  programs.zsh.enable = true;

  nix.enable = true;
  nix.package = pkgs.nix;

  system.primaryUser = "kuzzmi";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
