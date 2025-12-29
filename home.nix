{ pkgs, ... }:
{
  imports = [
    ./modules
  ];

  stylix.targets = {
    nvf.enable = false;
    starship.enable = false;
  };

  xdg = {
    autostart.enable = true;
    # configFile."keepassxc/keepassxc.ini".source = ./configFiles/keepassxc.ini;
  };

  home = {
    username = "kiwi";
    homeDirectory = "/home/kiwi";
    stateVersion = "25.05";

    packages = with pkgs; [
      fastfetch
      alacritty

      # Online
      signal-desktop
      firefox
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
  };

  programs.home-manager.enable = true;

  # Allow fc to find hm fonts
  fonts.fontconfig.enable = true;
}
