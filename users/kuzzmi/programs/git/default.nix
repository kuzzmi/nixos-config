{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    aliases = {
      g = "gui";
      s = "status -s";
      c = "commit";
      d = "diff";
      co = "checkout";
      cm = "commit -m";
      ca = "add -A . && git commit -m";
      pl = "pull --rebase";
      pull = "pull --rebase";
      ps = "push";
    };
    userName = "Igor Kuzmenko";
    userEmail = "igor@kuzzmi.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      safe = {
        directory = [
          "/nix/persist/etc/nixos"
        ];
      };
      url = {
        "git@bitbucket.org:" = {
          insteadOf = "https://bitbucket.org/";
        };
        "git@gitlab.com:" = {
          insteadOf = "https://gitlab.com/";
        };
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      init = {
        defaultBranch = "trunk";
      };
      push = {
        default = "current";
      };
      pull = {
        rebase = true;
      };
      gpg = {
        program = "gpg2";
      };
    };
  };
}
