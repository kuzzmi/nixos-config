{ config, pkgs, lib, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: postinstall: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
    postInstall = postinstall;
  };

  # always installs latest version
  plugin = repo: pluginGit "HEAD" repo "";
  pluginWithPost = repo: pluginGit "HEAD" repo;
in {
  home.file.".config/nvim/snippets" = {
    source = ./config/snippets;
  };
  home.file.".config/nvim/ftplugin" = {
    source = ./config/ftplugin;
  };
  home.file.".config/nvim/colors" = {
    source = ./config/colors;
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # withNodeJs = true;
    withPython3 = true;

    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./config/base.vim)
      (lib.strings.fileContents ./config/plugins.vim)

      ''
        lua << EOF
          ${lib.strings.fileContents ./config/lsp.lua}
        EOF
      ''
    ];
    extraPackages = with pkgs; [
      silver-searcher
      arduino-cli
      nodePackages.typescript
      nodePackages.typescript-language-server
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-compe
      # ncm2
      # nvim-yarp
      # yats-vim
      vim-ledger
      fzf-vim
      vim-nix
      vim-easy-align
      vim-startify
      tcomment_vim
      vim-abolish
      vim-fugitive
      tlib_vim
      ale
      unite-vim
      neomru-vim
      # vim-addon-mw-utils
      vim-airline
      vim-airline-themes
      vim-surround
      vim-repeat
      vim-snipmate
      vim-snippets
      vim-javascript
      auto-pairs
      # vim-es6
      vim-closetag
      typescript-vim
      vim-jsx-typescript
      Rename
      dressing-nvim
      (plugin "prisma/vim-prisma")
      (plugin "rking/ag.vim")
      (plugin "PeterRincker/vim-argumentative")
      (plugin "stevearc/vim-arduino")
    ];
  };
}
