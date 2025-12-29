{ inputs, pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    zip
    psmisc
    gcc
    glibc
    xdg-utils
    xdg-desktop-portal
    fzf
    bat
    eza
    nixfmt
    nixd
    efibootmgr
  ];

  # For nixd
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # Updates
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    dates = "weekly";
  };
}
