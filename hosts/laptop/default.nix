{ inputs, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };
  modules = [
    {
      imports = [
        ./hardware-configuration.nix
        ./modules/system
        ./modules/development
        ./modules/nixos/desktop.nix
        ./modules/nixos/flatpak.nix
        ./modules/nixos/nvidia.nix
        ./modules/nixos/packages.nix
        ./modules/nixos/shell.nix
        ./modules/nixos/theme.nix

        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
      ];

      # Nix settings
      nix.settings = {
        # Turn on Flakes
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        # devenv
        trusted-users = [
          "root"
          "kiwi"
        ];

        # Auto optimise
        auto-optimise-store = true;

        # Git warning
        warn-dirty = false;
      };

      # Firefox addonsoverwrite
      nixpkgs.overlays = [ inputs.nix-firefox-addons.overlays.default ];

      # User
      users.users.kiwi = {
        isNormalUser = true;
        description = "kiwi";
        extraGroups = [
          "networkmanager"
          "wheel"
          "adbusers"
          "kvm"
        ];
      };

      environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";

      # Backup Home Manager cleanup
      system.userActivationScripts = {
        removeConflictionBkpFiles = {
          text = ''
            find /home/kiwi/ -type f -name "*.nixos-backup-file" -delete
          '';
        };
      };

      # Enable XDG stuff
      xdg.portal.enable = true;

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "nixos-backup-file";

        extraSpecialArgs = { inherit inputs; };

        users.kiwi = {
          imports = [
            inputs.nvf.homeManagerModules.default

            ./modules/home/packages.nix
            ../../modules
          ];

          xdg.autostart.enable = true;

          # Show news
          news.display = "show";

          # Allow fc to find hm fonts
          fonts.fontconfig.enable = true;

          home = {
            username = "kiwi";
            homeDirectory = "/home/kiwi";

            stateVersion = "25.05";
          };

          programs.home-manager.enable = true;
        };
      };

      system.stateVersion = "25.11";
    }
  ];
}
