{
  description = "unixkiwi's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-firefox-addons.url = "github:osipog/nix-firefox-addons";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    stylix,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          stylix.nixosModules.stylix
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [inputs.nix-firefox-addons.overlays.default];

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

                  ./home.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
