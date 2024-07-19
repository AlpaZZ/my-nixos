{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
      inherit (self) outputs;
    in
    
   {
    # Please replace my-nixos with your hostname
    nixosConfigurations = {
      alpa-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs outputs;
      };

      modules = [
        ./nixos/configuration.nix
          inputs.home-manager.nixosModules.home-manager
        {
              home-manager = {
                users.alpa = import ./home;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
              };
           }
           (
            { pkgs, ... }:
              {
                nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
                environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
              }
           )
           inputs.stylix.nixosModules.stylix
        ];
      };
    }; 
  };
}