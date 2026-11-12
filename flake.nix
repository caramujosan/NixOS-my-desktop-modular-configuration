{
  description = "Modular NixOS and Home Manager Configuration with a Helper Function";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs:
    let
      # 1. Define the default architecture (can be parameterized if needed)
      system = "x86_64-linux";
      username = "caramujosan";

      # 2. Create a custom function to generate the configuration for each host
      # It takes the machine name (e.g., "desktop", "laptop") as an argument. 
      mkSystem = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          # Dynamically import the corresponding host directory
          ./hosts/${hostName}/configuration.nix

          # Home Manager integration
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
            ];
            # Dynamically import the home.nix file for the corresponding host
            home-manager.users.${username} = import ./hosts/${hostName}/home.nix;
          }
        ];
      };
    in {
      # 3. Apply the function to each machine
      nixosConfigurations = {
        desktop = mkSystem "desktop";
        laptop  = mkSystem "laptop";
      };
    };
}

