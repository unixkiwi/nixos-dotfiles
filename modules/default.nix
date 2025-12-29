{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./shell
    ./nvim
    ./theme
    ./utilities
    ./hypr
    ./browser
  ];
}
