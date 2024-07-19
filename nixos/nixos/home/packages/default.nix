{pkgs, ...}: 
{

  home.packages = with pkgs; [
    htop
    brave
  ];

 programs = {
  git = import ./git.nix;
 };

}