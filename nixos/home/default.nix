{ inputs, pkgs, ... }:
{

 home = {
    username = "alpa";
    homeDirectory = "/home/alpa";
    stateVersion = "24.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  };

   home.packages = with pkgs; [
    htop
    brave
  ];

}