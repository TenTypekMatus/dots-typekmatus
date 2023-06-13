{config, pkgs, lib, ... }:

{

  programs.neovim = {
    enable = true;
    extraConfig = lib.fileContents /home/matus/.config/nvim/init.vim.nonnixos
    plugins = [
    {
      plugin = vim-plug
      config = ''packadd! vim-plug'';
    }
  ];
  }

}