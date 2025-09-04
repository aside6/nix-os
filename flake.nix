{
  description = "NixOS + Home Manager flake for aside6";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
  };
  outputs = { self, nixpkgs, home-manager }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    # NixOS system
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };

    # Home Manager configuration
#    homeConfigurations.aside6 = home-manager.lib.homeManagerConfiguration {
#      inherit pkgs;
#      username = "aside6";
#      homeDirectory = "/home/aside6";

#      configuration = import ./home/home.nix;
#     homeConfigurations.asides = import ./home/home.nix;
   # };

    homeConfigurations.aside6 = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
    };
  };
}
