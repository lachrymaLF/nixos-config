{
  description = "lachrymal@NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2405.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    nixpkgs,
    nixpkgs-2405,
    home-manager,
    spicetify-nix,
    ...
  }: {
    nixosConfigurations.lachrymal-abg = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            users.lach = import ./home/lach.nix;
            extraSpecialArgs = {
              inherit inputs;
              inherit spicetify-nix;
              inherit nixpkgs-2405;
            };
          };
        }
      ];
    };
  };
}
