{
  #description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
     #  nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix
                    ./hardware-configuration.nix
                                         ];
        };

  };
}
