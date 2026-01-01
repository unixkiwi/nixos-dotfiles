{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
    alacritty

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
    vlc
    localsend

    # Languages
    cargo
    rustc
    flutter

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
  ];
}
