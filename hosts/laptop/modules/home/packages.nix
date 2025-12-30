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
    android-studio-full

    # Media stuff
    darktable
    vlc
    localsend

    # Languages
    cargo
    rustc
    flutter

    # Utils
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
