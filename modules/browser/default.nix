{ inputs, pkgs, ... }:
{
  home.file.".librewolf/librewolf.overrides.cfg".text = ''
    defaultPref("middlemouse.paste", false);
    defaultPref("general.autoScroll", true);
  '';

  home.file.".librewolf/kiwi/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;

  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-bin;

    profiles.kiwi = {
      extensions = {
        force = true;
        packages = with pkgs.firefoxAddons; [
          ublock-origin
          darkreader
          keepassxc-browser
        ];
      };

      settings = {
        "browser.tabs.loadInBackground" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
      };

      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';

      search = {
        default = "ecosia";
        order = [
          "ecosia"
          "mynixos"
          "nixos-search"
        ];

        engines = {
          ecosia = {
            name = "Ecosia";
            urls = [
              {
                template = "https://ecosia.org/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          mynixos = {
            name = "MyNixOS";
            urls = [
              {
                template = "https://mynixos.com/search";
                definedAliases = [ "@mn" ];
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          nixos-search = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                definedAliases = [ "@np" ];
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };
}
