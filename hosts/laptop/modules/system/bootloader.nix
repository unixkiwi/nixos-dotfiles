{ }:
{
  boot = {
    # Grub
    loader = {
      timeout = 2;
      systemd-boot.enable = false;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        efiInstallAsRemovable = true; # Conflicts with canTouchEfiVariables
      };
    };

    # Animation
    plymouth.enable = true;
  };
}
