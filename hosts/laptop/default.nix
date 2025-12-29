inputs:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };
  modules = [
    inputs.stylix.nixosModules.stylix
    ./configuration.nix
    inputs.home-manager.nixosModules.home-manager
    {
      nixpkgs.overlays = [ inputs.nix-firefox-addons.overlays.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "nixos-backup-file";

        extraSpecialArgs = {
          inherit
            inputs
            ;
        };

        users.kiwi = {
          imports = [
            inputs.nvf.homeManagerModules.default

            ../../home.nix
          ];
        };
      };
    }
  ];
}
