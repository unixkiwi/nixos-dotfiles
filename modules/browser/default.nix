{ inputs, pkgs, ... }:
{
  home.file.".librewolf/kiwi/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;

  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-bin;

    languagePacks = [
      "en-US"
      "de"
    ];

    profiles.kiwi = {
      isDefault = true;
      extensions = {
        force = true;
        packages = with pkgs.firefoxAddons; [
          ublock-origin
          darkreader
          keepassxc-browser
        ];
      };

      settings = {
        # General
        "browser.tabs.loadInBackground" = true;
        "browser.download.useDownloadDir" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.uiCustomization.state" =
          ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","vertical-spacer","urlbar-container","customizableui-special-spring2","downloads-button","fxa-toolbar-menu-button","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","keepassxc-browser_keepassxc_org-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","ublock0_raymondhill_net-browser-action","screenshot-button","addon_darkreader_org-browser-action","keepassxc-browser_keepassxc_org-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","unified-extensions-area","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":23,"newElementCount":4}'';
        "layout.spellcheckDefault" = 0;
        "browser.tabs.closeWindowWithLastTab" = false;
        "sidebar.visibility" = "hide-sidebar";
        "browser.startup.homepage" = "https://github.com";

        # Privacy & Security
        "browser.contentblocking.category" = "strict";

        # Rounded corners
        "widget.gtk.rounded-bottom-corners.enabled" = true;

        # Theme
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;

        # Middle Mouse scroll
        "middlemouse.paste" = false;
        "general.autoScroll" = true;
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
                iconMapObj."48" = "https://ecosia.org/favicon.ico";
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
