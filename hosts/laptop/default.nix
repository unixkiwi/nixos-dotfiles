inputs:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };
  modules = [
    {
      imports = [
        ../../hardware-configuration.nix
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

      # Turn on Flakes
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Firefox addonsoverwrite
      nixpkgs.overlays = [ inputs.nix-firefox-addons.overlays.default ];

      # User
      users.users.kiwi = {
        isNormalUser = true;
        description = "kiwi";
        shell = pkgs.fish;
        extraGroups = [
          "networkmanager"
          "wheel"
          "adbusers"
          "kvm"
        ];
      };

      # Backup Home Manager cleanup
      system.userActivationScripts = {
        removeConflictionBkpFiles = {
          text = ''
            find /home/kiwi/ -type f -name "*.nixos-backup-file" -delete
          '';
        };
      };

      # Enable XDG; needed by flatpak I think
      xdg.portal.enable = true;

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "nixos-backup-file";

        extraSpecialArgs = { inherit inputs; };

        users.kiwi = {
          imports = [
            inputs.nvf.homeManagerModules.default

            ../../home.nix
          ];
        };
      };

      system.stateVersion = "25.11";
    }
  ];
}
