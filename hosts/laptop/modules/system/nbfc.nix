{
  inputs,
  config,
  pkgs,
  ...
}:
let
  cfg = pkgs.writeText "nbfc.json" (
    builtins.toJSON {
      SelectedConfigId = "Acer Aspire VN7-792G V17 Nitro BE";
    }
  );
in
{
  environment.systemPackages = [
    pkgs.nbfc-linux
  ];

  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig.Type = "simple";
    path = [ pkgs.kmod ];

    script = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file '${cfg}'";

    wantedBy = [ "multi-user.target" ];
  };
}
