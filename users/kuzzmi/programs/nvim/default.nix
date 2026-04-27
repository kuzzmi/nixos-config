{ pkgs, lib, ... }:
let
  plugin = owner: repo: rev: sha256:
    pkgs.vimUtils.buildVimPlugin {
      pname = repo;
      version = rev;
      src = pkgs.fetchFromGitHub { inherit owner repo rev sha256; };
    };
in {
  home.file = {
    ".config/nvim/snippets" = { source = ./config/snippets; };
    ".config/nvim/ftplugin" = { source = ./config/ftplugin; };
    ".config/nvim/colors" = { source = ./config/colors; };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    # withNodeJs = true;

    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./config/base.vim)
      (lib.strings.fileContents ./config/plugins.vim)
    ];

    extraLuaConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./config/utils.lua)
      (lib.strings.fileContents ./config/base.lua)
      (lib.strings.fileContents ./config/menu.lua)
      (lib.strings.fileContents ./config/lsp.lua)
      (lib.strings.fileContents ./config/plugins.lua)
    ];

    extraPackages = with pkgs; [
      silver-searcher
      gopls
      platformio
      clang-tools
      nixd
      nixfmt
      typescript
      typescript-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim

      # LSP, completion and diagnostics
      nvim-lspconfig
      ale
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      # (plugin "hrsh7th/cmp-cmdline")
      # (plugin "hrsh7th/cmp-omni")
      nvim-snippy
      cmp-snippy
      trouble-nvim

      # Formatting
      vim-easy-align
      vim-surround
      vim-repeat
      auto-pairs
      vim-closetag
      Rename
      tcomment_vim
      (plugin "cxw42" "change-case.vim"
        "6c86c365957430faec9baac68f8e05b2ab87b7b9"
        "sha256-iX75rkLEhOP1rVDwphs+9HvIHIRotiK8RIPeTMnluEA=")
      vim-argumentative

      # Navigation
      fzf-vim
      (plugin "kelly-lin" "telescope-ag"
        "7d25064da3c7689461bcfa89ad1f08548415193d"
        "sha256-xOgiiTElHLgx7Gwp6aR0Ipfanq6ZTTgiQv9Zs3LTb1g=")

      # File specific plugins
      typescript-vim
      vim-jsx-typescript
      vim-javascript
      vim-ledger
      vim-prisma
      (plugin "normen" "vim-pio" "6bba1d4e4c57f3bfadd0b3163652985a61764ab7"
        "sha256-BW+bBb17+ukfWTg1zMMBxHk0thL6xFWiPXuHjB5K6VE=")

      # Misc
      vim-startify # lovely cow
      zen-mode-nvim
      vim-snippets

      vim-abolish
      vim-fugitive
      tlib_vim
      dressing-nvim
      lualine-nvim
      nvim-web-devicons
      ollama-nvim
      gen-nvim

      plenary-nvim
      telescope-nvim
    ];
  };
}
