{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        # normal.family = "CaskaydiaCove Nerd Font Mono";
      };
    };
  };
}
