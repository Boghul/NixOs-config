{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

     home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


   outputs = inputs@{ self,
                      nixpkgs,
                      systems,
                      home-manager,
                       }:   {
      specialArgs = { inherit inputs; };


    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./nixos/configuration.nix
        ./nixos/hardware-configuration.nix
        ./nixos/zshrc.nix


         home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.root = import ./home.nix;
            backupFileExtension = "backup";
          };
        }

        ];
    };

  };
}
