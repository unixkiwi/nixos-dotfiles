{ inputs, ... }:
{
  # Hostname
  networking.hostName = "laptop";

  # Networkmanager
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # SSH
  services.openssh.enable = true;
}
