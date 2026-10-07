{
  description = "Configuração Modular do NixOS e Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Adds the nix-flatpak source
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./desktop/configuration.nix

          # 1. Carrega todos os módulos de sistema em modo passivo
          ./modules/system

          # 2. Integração do Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            
            # Injects the nix-flatpak Home Manager module for all users
            home-manager.sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
            ];

            home-manager.users.caramujosan = import ./desktop/home.nix;
          }
        ];
      };
    };
  };
}


