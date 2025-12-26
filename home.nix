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

      # Messaging
      signal-desktop
      firefox

      # Fonts
      nerd-fonts.caskaydia-cove

      # Editors
      neovim

      # Languages
      cargo
      rustc
      flutter

      # Utils
      btop
      bat
      fd
      rsync
      lazygit
      tmux
      tealdeer
      ripgrep
    ];
  };

  programs.home-manager.enable = true;

  # Allow fc to find hm fonts
  fonts.fontconfig.enable = true;
}
