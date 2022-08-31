{ config, pkgs, ... }:

let
  agenix = builtins.fetchTarball {
    url = "https://github.com/ryantm/agenix/archive/main.tar.gz";
  };
in {
  imports = [
    "${agenix}/modules/age.nix"
    ./users/kuzzmi/default.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      neovim
      ranger
      (pkgs.callPackage "${agenix}/pkgs/agenix.nix" {})
    ];
  };

  time.timeZone = "Europe/Kiev";

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d --max-freed $((64 * 1024**3))";
    };
  };
}
