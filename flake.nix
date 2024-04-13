{
  description = "lachrymal@NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs@{ nixpkgs, home-manager, spicetify-nix, ... }: {
    nixosConfigurations.lachrymal-abg = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.lach = import ./home/lach.nix;
            extraSpecialArgs = {
              inherit inputs;
              inherit spicetify-nix;
            };
          };
        }
      ];      
    };
  };
}
