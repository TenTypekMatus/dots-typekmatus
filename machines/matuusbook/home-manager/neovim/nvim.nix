{config, pkgs, lib, ... }:

{

  programs.neovim = {
    enable = true;
    extraConfig = lib.fileContents ~/.config/nvim/init.vim.nonnixos
    plugins = [
    {
      plugin = vim-plug
      config = ''packadd! vim-plug'';
    }
  ];
  }

}