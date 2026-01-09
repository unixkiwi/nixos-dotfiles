{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shell
    ../../modules/browser
    ../../modules/utilities
  ];

  home.username = "kiwi";
  home.homeDirectory = "/home/kiwi";
  home.stateVersion = "25.11";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.packages = [

    pkgs.lsd
  ];

  home.sessionVariables = {
    TEST="HELLO";
  };

  programs.home-manager.enable = true;
}
