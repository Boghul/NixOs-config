


let
    pkgs = import <nixpkgs> {};

    tte = pkgs.callPackage (pkgs.fetchFromGitHub {
        owner = "ChrisBuilds";
        repo = "terminaltexteffects";
        rev = "<revision, e.g. main/v0.13.0/etc.>";
        hash = "";
        }) {};
in
    pkgs.mkShell {
        packages = [tte];
        }

