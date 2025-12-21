{
  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-25.11"; };
    nixpkgs-unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    musnix  = { url = "github:musnix/musnix"; };
    nixos-hardware = { url =  "github:NixOS/nixos-hardware/master"; };
    home-manager = { url = "github:nix-community/home-manager"; };
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, musnix, nixos-hardware, home-manager, ... } @ inputs: 
    let
      system = "x86_64-linux";
      #overlay-unstable = final: prev: {
      #  unstable = import inputs.nixpkgs-unstable {
      #    inherit system;
      #    config.allowUnfree = true;
      #  };
      #};
      pkgs = import nixpkgs {
        inherit system;
        #config = {
        #  allowUnfree = true;
        #};
        overlays = [ 
          musnix.overlay
          #overlay-unstable
        ];
      };
    in
    rec {
    nixosConfigurations.bepithonk = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [ 
            inputs.musnix.nixosModules.musnix
            ./configuration.nix
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p43s
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.hyfudiar = ./home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        specialArgs = { inherit inputs; };
    };
  };
}
#...
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
