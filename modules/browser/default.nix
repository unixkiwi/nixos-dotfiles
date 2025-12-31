{ inputs, lib, ... }:
{
  imports = [ inputs.betterfox.modules.homeManager.betterfox ];

  home.file.".mozilla/firefox/kiwi/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;

  programs.firefox = {
    enable = true;

    policies = {
      AppAutoUpdate = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      BlockAboutConfig = false; # lets see if i can do everything using policies
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "never";
      DontCheckDefaultBrowser = true;
      DownloadDirectory = "\${home}/Downloads";
      # Exclude on clear
      Cookies = {
        Allow = [
          "https://github.com"
          "https://beste.schule"
          "https://monkeytype.com"
        ];
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
        Locked = true;
      };
      HardwareAcceleration = true;
      Homepage = {
        StartPage = "previous-session";
      };
      NoDefaultBookmarks = true;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      PostQuantumKeyAgreementEnabled = true; # idk lets see if it causes issues but sounds good
      Preferences = {
        "browser.urlbar.showSearchTerms.enabled" = {
          Value = true;
          Status = "locked";
        };
        "browser.tabs.loadInBackground" = {
          Value = true;
          Status = "locked";
        };
        "browser.download.useDownloadDir" = {
          Value = true;
          Status = "locked";
        };
        "browser.toolbars.bookmarks.visibility" = {
          Value = "never";
          Status = "locked";
        };
        "browser.uiCustomization.state" = {
          Value = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","vertical-spacer","urlbar-container","customizableui-special-spring2","downloads-button","fxa-toolbar-menu-button","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","keepassxc-browser_keepassxc_org-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","ublock0_raymondhill_net-browser-action","screenshot-button","addon_darkreader_org-browser-action","keepassxc-browser_keepassxc_org-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","unified-extensions-area","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":23,"newElementCount":4}'';
          Status = "locked";
        };
        "layout.spellcheckDefault" = {
          Value = 0;
          Status = "locked";
        };
        "browser.tabs.closeWindowWithLastTab" = {
          Value = false;
          Status = "locked";
        };
        "sidebar.verticalTabs" = {
          Value = false;
          Status = "locked";
        };
        "sidebar.visibility" = {
          Value = "hide-sidebar";
          Status = "locked";
        };
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "widget.gtk.rounded-bottom-corners.enabled" = {
          Value = true;
          Status = "locked";
        };
        "toolkit.legacyUserProfileCustomizations.stylesheets" = {
          Value = true;
          Status = "locked";
        };
        "svg.context-properties.content.enabled" = {
          Value = true;
          Status = "locked";
        };
        "gnomeTheme.hideSingleTab" = {
          Value = true;
          Status = "locked";
        };
        "gnomeTheme.normalWidthTabs" = {
          Value = false;
          Status = "locked";
        };
        "gnomeTheme.tabsAsHeaderbar" = {
          Value = false;
          Status = "locked";
        };
        "middlemouse.paste" = {
          Value = false;
          Status = "locked";
        };
        "general.autoScroll" = {
          Value = true;
          Status = "locked";
        };
      };
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        Downloads = true;
        FormData = true;
        History = false;
        OfflineApps = false;
        Locked = true;
      };
      SearchBar = "unified";
      SearchEngines = {
        Add = [
          {
            Alias = "@np";
            Description = "Search in NixOS Packages";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Packages";
            URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
          }
          {
            Alias = "@mynix";
            Description = "Search in mynixos";
            IconURL = "https://mynixos.com/favicon.ico";
            Method = "GET";
            Name = "MyNixOS";
            URLTemplate = "https://mynixos.com/search?q={searchTerms}";
          }
          {
            Alias = "@no";
            Description = "Search in NixOS Options";
            IconURL = "https://nixos.org/favicon.png";
            Method = "GET";
            Name = "NixOS Options";
            URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
        ];
      };
      # Extensions
      ExtensionSettings = {
        "*" = {
          installation_mode = "blocked";
          blocked_install_message = "Extensions must be declared and installed within the nix config!";
        };
        "uBlock0@raymondhill.net" = {
          default_area = "navbar";
          installation_mode = "force_installed";
          private_browsing = true;
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "addon@darkreader.org" = {
          default_area = "navbar";
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };
        "keepassxc-browser@keepassxc.org" = {
          default_area = "navbar";
          installation_mode = "force_installed";
          private_browsing = true;
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
        };
      };
      # See https://github.com/Arcanyx-org/NiXium
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            advancedUserEnabled = true;
            autoUpdate = true;
            cloudStorageEnabled = false;
            importedLists = [
              "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.mini.txt"
              "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
              "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
              "https://raw.githubusercontent.com/liamengland1/miscfilters/master/antipaywall.txt"
              "https://gitflic.ru/project/magnolia1234/bypass-paywalls-clean-filters/blob/raw?file=bpc-paywall-filter.txt"
              "https://raw.githubusercontent.com/iam-py-test/uBlock-combo/main/list.txt"
            ];
            externalLists = lib.concatStringsSep "\n" importedLists;
          };
          selectedFilterLists = [
            "user-filters"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "ublock-experimental"
            "easylist"
            "adguard-generic"
            "easyprivacy"
            "adguard-spyware-url"
            "urlhaus-1"
            "curben-phishing"
            "plowe-0"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "adguard-cookies"
            "ublock-cookies-adguard"
            "fanboy-ai-suggestions"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "adguard-mobile-app-banners"
            "adguard-other-annoyances"
            "adguard-popup-overlays"
            "adguard-widgets"
            "ublock-annoyances"
            "DEU-0"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
            "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.mini.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
            "https://raw.githubusercontent.com/liamengland1/miscfilters/master/antipaywall.txt"
            "https://gitflic.ru/project/magnolia1234/bypass-paywalls-clean-filters/blob/raw?file=bpc-paywall-filter.txt"
            "https://raw.githubusercontent.com/iam-py-test/uBlock-combo/main/list.txt"
          ];
        };
      };
    };

    betterfox = {
      enable = true;

      profiles.kiwi = {
        # Set this to enable all sections by default
        enableAllSections = true;

        settings = {
          # To enable/disable specific sections
          fastfox.enable = true;

          # To enable/disable specific subsections
          peskyfox = {
            enable = true;
            ai.enable = false;
            theme-adjustments.enable = true;
          };

          # To enable/disable specific options
          securefox = {
            enable = true;
            passwords.enable = false;
          };
        };
      };
    };

    languagePacks = [
      "en-US"
      "de"
    ];

    profiles.kiwi = {
      isDefault = true;
      /*
        extensions = {
          force = true;
          packages = with pkgs.firefoxAddons; [
            # ublock-origin
            darkreader
            keepassxc-browser
          ];
        };
      */

      /*
        settings = {
          # General
          "browser.tabs.loadInBackground" = true;
          "browser.download.useDownloadDir" = true;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.uiCustomization.state" =
            ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","vertical-spacer","urlbar-container","customizableui-special-spring2","downloads-button","fxa-toolbar-menu-button","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","keepassxc-browser_keepassxc_org-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","ublock0_raymondhill_net-browser-action","screenshot-button","addon_darkreader_org-browser-action","keepassxc-browser_keepassxc_org-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","unified-extensions-area","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":23,"newElementCount":4}'';
          "layout.spellcheckDefault" = 0;
          "browser.tabs.closeWindowWithLastTab" = false;
          "sidebar.verticalTabs" = false;
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
      */

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
