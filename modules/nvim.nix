{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkForce true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim            
      LazyVim             
      bufferline-nvim
      lualine-nvim
      tokyonight-nvim      

      (nvim-treesitter.withPlugins (p: [ 
        p.nix 
        p.lua 
        p.vim 
        p.bash
        p.markdown
        p.python
        p.javascript
      ]))
    ];

    

    extraPackages = with pkgs; [
      ripgrep
      fd
      lua-language-server
      gcc
      tree-sitter
      gnumake
    ];

    extraLuaConfig = ''
      vim.keymap.set("i", "jj", "<Esc>")
    '';
  };

  home.file.".config/nvim" = {
    source = ./nvim-config;
    recursive = true;
  };
}
