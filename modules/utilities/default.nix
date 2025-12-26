{
  config,
  lib,
  pkgs,
  ...
}: {
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
