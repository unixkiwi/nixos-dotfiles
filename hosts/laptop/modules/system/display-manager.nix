{ pkgs, lib, ... }:
{
  # Display Manager
  /*
    services.displayManager = {
      enable = true;
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = [ pkgs.sddm-astronaut ];
      };
    };
  */
  services.displayManager.sddm = {
    enable = true;
    package = lib.mkForce pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      sddm-astronaut
      kdePackages.qt5compat
    ];
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    enableHidpi = true;
    settings = {
      General = {
        DisplayServer = "wayland";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];
}
