{ }:
{
  # Some mounting stuff
  services = {
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # NTFS support
  boot.supportedFilesystems = [ "ntfs" ];

  # Cleanup
  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
