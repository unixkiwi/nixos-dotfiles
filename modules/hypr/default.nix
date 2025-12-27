{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
    };
  };

  programs.kitty.enable = true;
}
