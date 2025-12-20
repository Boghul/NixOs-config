{
  #description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    vicinae.url = "github:vicinaehq/vicinae";
    awww.url = "git+https://codeberg.org/LGFae/awww";

    
    steam-fetcher.url = "github:aidalgol/nix-steam-fetcher";  # Steam fetcher for NixOS

       home-manager = {
        url = "github:nix-community/home-manager/release-25.05";
        inputs.nixpkgs.follows = "nixpkgs";
        };
   };

   outputs = inputs@{ self,
                      nixpkgs,
                      systems, 
                      vicinae, 
                      awww, 
                      home-manager,
                      steam-fetcher }: {
    specialArgs = { inherit inputs; };

    
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix
                    ./hardware-configuration.nix
                  # ./vicinae
                  #  ./awww.nix
                  
                  home-manager.nixosModules.home-manager 
                   {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.xenomorph = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
