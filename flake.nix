{
  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    musnix  = { url = "github:musnix/musnix"; };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = inputs: rec {
    nixosConfigurations.bepithonk = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [ # ...
            inputs.musnix.nixosModules.musnix
            ./configuration.nix
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p43s
          ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
#{
#  inputs = {
#    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
#  };
#  outputs = { self, nixpkgs }: {
#    # replace 'joes-desktop' with your hostname here.
#    nixosConfigurations.bepithonk = nixpkgs.lib.nixosSystem {
#      system = "x86_64-linux";
#      modules = [ ./configuration.nix ];
#    };
#  };
#}
