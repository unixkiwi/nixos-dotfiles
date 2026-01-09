{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.autostart.enable = true;
  programs = {
    btop = {
      enable = true;
      settings = {
        update_ms = 100;
      };
    };
    keepassxc = {
      enable = true;
      autostart = true;
    };
    nh = {
      enable = true;
      flake = "/home/kiwi/nixos-dotfiles";
    };
    tealdeer = {
      enable = true;
      settings = {
        updates = {
          auto_update = true;
        };
      };
    };
  };
}
