{pkgs, ...}: {
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
    file.".config/keepassxc/keepassxc.ini" = {
      force = true;
      text = ''
                [Browser]
        Enabled=true
        MatchUrlScheme=false
        SearchInAllDatabases=true

        [GUI]
        ApplicationTheme=dark
        ColorPasswords=true
        CompactMode=false
        HidePasswords=false
        MinimizeOnClose=true
        MinimizeToTray=true
        ShowTrayIcon=true
        TrayIconAppearance=monochrome-dark

        [General]
        ConfigVersion=2
      '';
    };
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

      # Media stuff
      darktable
      vlc

      # Languages
      cargo
      rustc
      flutter

      # Utils
      ncdu
      btop
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
