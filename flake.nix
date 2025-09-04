{
  description = "Minimal Home Manager flake for aside6";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };

    homeManagerConfigurations.aside6 = home-manager.lib.homeManagerConfiguration {
      inherit system;
      username = "aside6";
      homeDirectory = "/home/aside6";

      # Use your existing home.nix directly
      configuration = import ./home.nix;
    };
  };
}
