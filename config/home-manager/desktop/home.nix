{ config, pkgs, lib, ... }:
{
imports = 
[ 
];


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "matus";
  home.homeDirectory = "/home/matus";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Agave" ]; })
    # GNOME Extensions
    gnomeExtensions.material-you-color-theming
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.privacy-settings-menu
    gnomeExtensions.gsconnect
    adw-gtk3
    # CLI
    github-cli
    bat
    obs-studio
    python311Packages.pynvim
    xorg.xprop
    lua
    discord
    alacritty
    xfce.thunar
    pavucontrol
    autotiling
    wofi
    starship
    fish
    exa
    musikcube
    papirus-icon-theme
    nordic
    jetbrains.idea-community
    vlang
    prismlauncher
    rustup
    gcc
    gnumake
    spotify
    noto-fonts-emoji
];
  programs.git = {
    enable = true;
    userName = "Matus Mastena";
    userEmail = "Shadiness9530@proton.me";
  };

nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
             "discord"
             "spotify"
];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/matus/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
