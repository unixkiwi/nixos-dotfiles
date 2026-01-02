{ config, pkgs, ... }:
{
  # Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    /*
      fonts = {
        monospace.package = pkgs.nerd-fonts.caskaydia-cove;
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;
      };
    */
  };
}
