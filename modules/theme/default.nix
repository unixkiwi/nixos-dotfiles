{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    override = {
      base00 = "#191c1e";
      base01 = "#383432";
      base02 = "#4c4541";
      base03 = "#624f50";
      base04 = "#afaa8f";
      base05 = "#d1c09e";
      base06 = "#e9d8ad";
    };

    fonts = {
      sizes = {
        terminal = 12;
        applications = 13;
        popups = 11;
      };

      serif = {
        name = "CaskaydiaCove Nerd Font";
        package = pkgs.nerd-fonts.caskaydia-cove;
      };

      sansSerif = {
        name = "CaskaydiaCove Nerd Font";
        package = pkgs.nerd-fonts.caskaydia-cove;
      };

      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 24;
    };

    targets = {
      nvf.enable = false;
      starship.enable = false;
      wofi.enable = false;
      waybar.enable = false;
      vscode.enable = false;
    };
  };
  gtk = {
    enable = true;
  };
}
