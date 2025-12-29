{ inputs, ... }:
{
  # Hostname
  networking.hostName = "laptop";

  # Networkmanager
  networking.networkmanager.enable = true;

  # SSH
  services.openssh.enable = true;
}
