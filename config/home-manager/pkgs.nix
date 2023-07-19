{config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Agave" ]; })
    # CLI
    distrobox
    python311Packages.pynvim
    python310Packages.setuptools
    python310Packages.pip
    helix
    filezilla
    xsel
    deluge
    freetube
    go
    dep
    ansible
    ansible-lint
    nodejs
    python3
    github-cli
    xfce.thunar
    pfetch
    nordic
    protonmail-bridge
    yarn
    bat
    python311Packages.pynvim
    xorg.xprop
    pantheon.wingpanel-with-indicators
    lua
    swaybg
    lollypop
    discord
    alacritty
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
    vlang
    swayidle
    swaylock-fancy
  ];
}
