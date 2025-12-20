{
  #description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    vicinae.url = "github:vicinaehq/vicinae";

    awww.url = "git+https://codeberg.org/LGFae/awww";
    
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.6.tar.gz"; # uncomment line for solaar version 1.1.18
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    
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
                      steam-fetcher,
                      solaar  }:   {
   
        specialArgs = { inherit inputs; };
    
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix
                    ./hardware-configuration.nix
                  
                                     
                  solaar.nixosModules.default
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
