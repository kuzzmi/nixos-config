{ config, pkgs, ... } :
let
  inherit (pkgs) stdenv;
in {
  programs.zsh = {
    enable = true;
    shellAliases = {
      r = "ranger";
      vim = "nvim";
      tmx = "tmuxinator";
      tmxf = "tmuxinator start fin -p ~/.config/tmuxinator/fin.yml";
      g = "git";
      tmux = "tmux -u";
      ll = "ls -l";
      le = "ledger --no-pager -f ~/Documents/Finances/ledger/ledger.dat";
      up = if stdenv.isLinux then "sudo nixos-rebuild switch" else "darwin-rebuild switch";
      nre = "sudo nvim /etc/nixos/configuration.nix";
      nreu = "nvim ${if stdenv.isLinux then "/etc/nixos" else "/home/kuzzmi/.nixpkgs"}/users/kuzzmi/default.nix";
      agenix = "RULES=/etc/nixos/users/kuzzmi/secrets/rules.nix agenix";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "yarn" "gpg-agent" "docker" ];
      theme = "minimal";
      custom = "./custom";
    };
    initExtraFirst = ''
      HYPHEN_INSENSITIVE="true"
      COMPLETION_WAITING_DOTS="true"
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11"
      export EDITOR='nvim'
    '';
    initExtra = ''
      export GDK_SCALE=2
      export GDK_DPI_SCALE=0.75
      zshaddhistory() {
        case ''${1%% *} in
          (xvideos) return 1;;
        esac
        return 0;
      }
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
    '';
    history = {
      size = 10000;
      path = "/home/kuzzmi/.config/zsh/history";
    };
  };
}
