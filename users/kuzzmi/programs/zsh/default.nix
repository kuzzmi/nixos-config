{ config, pkgs, ... }:
let
  inherit (pkgs) stdenv;
  nixConfigRoot =
    "${if stdenv.isLinux then "/etc/nixos" else "/Users/kuzzmi/.nixpkgs"}";
in {
  programs.fzf.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      r = "ranger";
      vim = "nvim";
      tmx = "tmuxinator";
      tmxf = "tmuxinator start fin -p ~/.config/tmuxinator/fin.yml";
      g = "git";
      gcob = "git checkout $(git branch | fzf)";
      tmux = "tmux -u";
      ll = "ls -l";
      le = "hledger -f ~/Private/Finances/hledger/hledger.journal";
      up = if stdenv.isLinux then
        "sudo nixos-rebuild switch"
      else
        "darwin-rebuild switch";
      nre = "sudo nvim ${nixConfigRoot}/common-configuration.nix";
      nreu = "nvim ${nixConfigRoot}/users/kuzzmi/default.nix";
      edit-nvim =
        "nvim ${nixConfigRoot}/users/kuzzmi/programs/nvim/default.nix";
      agenix = "RULES=${nixConfigRoot}/users/kuzzmi/secrets/rules.nix agenix";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "yarn" "gpg-agent" "docker" ];
      theme = "juanghurtado";
      custom = "./custom";
    };
    initExtraFirst = ''
      export BAT_THEME="ansi"
      HYPHEN_INSENSITIVE="true"
      COMPLETION_WAITING_DOTS="true"
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11"
      export EDITOR="nvim"
      zstyle ':omz:alpha:lib:git' async-prompt no
    '';
    initExtra = ''
      export GDK_SCALE=2
      export GDK_DPI_SCALE=0.75
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
      export PATH=$PATH:/Users/kuzzmi/Library/Python/3.9/bin:/Users/kuzzmi/.local/bin
    '';
    history = {
      size = 10000;
      path = "${
          if stdenv.isLinux then "/home" else "/Users"
        }/kuzzmi/.config/zsh/history";
    };
  };
}
