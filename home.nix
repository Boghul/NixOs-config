{ config, pkgs, ... }:

{
  home = {
    username = "xenomorph"; # Change to your username
    homeDirectory = "/home/xenomorph";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;
  };
  
  programs = {
    bash = {
        enable = true;
        shellAliases = {
            btw = "echo i use nixos, btw";
            };
         };
    home-manager.enable = true;

    git = {
        enable = true;
        userName = "Boghul";
        userEmail = "your.email@address";
         };
    };

    
}
