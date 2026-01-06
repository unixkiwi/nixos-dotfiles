{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch

    # Online
    signal-desktop
    ungoogled-chromium
    tor-browser

    # Fonts
    nerd-fonts.caskaydia-cove

    # Editors
    neovim
    vscode
    android-studio

    # Media stuff
    darktable
    rapidraw
    vlc
    localsend
    inkscape

    # Languages
    cargo
    rustc
    devenv
    nodejs
    python3
    go
    gcc
    binutils

    # Utils
    fx
    ncdu
    btop
    nvtopPackages.full
    bat
    fd
    rsync
    lazygit
    tmux
    tealdeer
    ripgrep
    gparted
    qalculate-gtk
    unar
  ];
}
