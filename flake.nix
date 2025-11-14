{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nvim.url = "github:ItzEmoji/nvim";
    home-manager.url = "github:nix-community/home-manager/master";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          inputs.nixos-wsl.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cyril = {
              imports = [
                ./home.nix
                ./config/cli/cli.nix
              ];
            };
          }
          {
            imports = [
              ./configuration.nix
            ];
          }
        ];
      };
    };
  };
}
