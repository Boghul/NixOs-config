{ config, pkgs, ... }:

{
  home.username = "root";
  home.homeDirectory = "/root";
  programs.git.enable = true;
  home.stateVersion = "25.05";


  home.packages = with pkgs; [];

}
