{ inputs, ... }:
{
  # Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # KDE
  services.desktopManager.plasma6.enable = true;
}
