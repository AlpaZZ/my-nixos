{pkgs, ...}: 
{

  home.packages = with pkgs; [
    htop
    brave
  ];

  import = [
    ../nixvim.nix
  ]

}
