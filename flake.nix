{
  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    musnix  = { url = "github:musnix/musnix"; };
  };
  outputs = inputs: rec {
    nixosConfigurations = {
      example-config = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [ # ...
            inputs.musnix.nixosModules.musnix
            ./configuration.nix
          ];
        specialArgs = { inherit inputs; };
      };
    };
  };
# ...
