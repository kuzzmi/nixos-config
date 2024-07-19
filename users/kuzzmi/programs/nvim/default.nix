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
    ];

    extraLuaConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./config/base.lua)
      (lib.strings.fileContents ./config/lsp.lua)
      (lib.strings.fileContents ./config/plugins.lua)
    ];

    extraPackages = with pkgs; [
      silver-searcher
      gopls
      platformio
      clang-tools
      nixd
      nodePackages.typescript
      nodePackages.typescript-language-server
    ];
    plugins = with pkgs.vimPlugins; [
      # LSP, completion and diagnostics
      nvim-lspconfig
      nvim-compe
      ale
      (plugin "folke/trouble.nvim")

      # Formatting
      vim-easy-align
      vim-surround
      vim-repeat
      auto-pairs
      vim-closetag
      Rename
      tcomment_vim
      (plugin "cxw42/change-case.vim")
      (plugin "PeterRincker/vim-argumentative")

      # Navigation
      fzf-vim
      (plugin "kelly-lin/telescope-ag")

      # File specific plugins
      typescript-vim
      vim-jsx-typescript
      vim-javascript
      vim-ledger
      (plugin "prisma/vim-prisma")
      (plugin "normen/vim-pio")
      # (plugin "stevearc/vim-arduino")

      # Misc
      vim-startify # lovely cow
      zen-mode-nvim
      vim-snipmate
      vim-snippets

      vim-abolish
      vim-fugitive
      tlib_vim
      dressing-nvim
      (plugin "nvim-lualine/lualine.nvim")
      (plugin "nvim-tree/nvim-web-devicons")
      (plugin "David-Kunz/gen.nvim") # Local LLM integration

      (plugin "nvim-lua/plenary.nvim")
      (plugin "nvim-telescope/telescope.nvim")
    ];
  };
}
