{pkgs, ...}: {
  home.file.".librewolf/librewolf.overrides.cfg".text = ''
    defaultPref("middlemouse.paste", false);
    defaultPref("general.autoScroll", true);
  '';

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
                definedAliases = ["@mn"];
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
                definedAliases = ["@np"];
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
