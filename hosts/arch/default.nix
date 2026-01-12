{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.nvf.homeManagerModules.default

    ../../modules/browser
    ../../modules/hypr
    ../../modules/shell
    ../../modules/nvim
    ../../modules/utilities
    ../../modules/terminal
    ../../modules/theme
    ../../modules/vscode
  ];

  targets.genericLinux.enable = true;

  home.username = "kiwi";
  home.homeDirectory = "/home/kiwi";
  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  home.packages = with pkgs; [
    nixd
    nil
    networkmanagerapplet
    libsecret
    libnotify
  ];

  services.network-manager-applet.enable = true;

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  fonts.fontconfig.enable = true;

  home.activation.removeHomeManagerBackups = lib.hm.dag.entryAfter [ "checkFilesChanged" ] ''
    find /home/kiwi/ -type f -name "*.home-manager-backup" -delete
  '';

  programs.home-manager.enable = true;
}
