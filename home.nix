{ config, pkgs, inputs, ... }:

{
  home = {
    username = "xenomorph";
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
        userEmail = "thorsten.boeck@web.de";
         };

 #   dconf.profiles.user.databases = [
 # {
 #   lockAll = true; # prevents overriding
 #   settings = {
 #     "org/gnome/desktop/interface" = {
 #       color-scheme = "prefer-dark";
 #     };
 #   };
 # }
#];

    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        #package = [pkgs.adwaita-dark];
        };
      iconTheme = {
        name = "Adwaita-dark";
        #package = [pkgs.gnome.adwaita-icon-theme];
        };
      cursorTheme = {
        name = "Adwaita-dark";
       # package = [pkgs.gnome.adwaita-icon-theme];
        };
    };
}


    

