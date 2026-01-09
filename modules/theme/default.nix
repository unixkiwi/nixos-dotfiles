{ ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    override = {
      base00 = "#191c1e";
      base01 = "#383432";
      base02 = "#4c4541";
      base03 = "#624f50";
      base04 = "#afaa8f";
      base05 = "#d1c09e";
      base06 = "#e9d8ad";
    };
    targets = {
      nvf.enable = false;
      starship.enable = false;
    };
  };
  gtk = {
    enable = true;
  };
}
