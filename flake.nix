{
  inputs.nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

  inputs.home-manager.url = github:nix-community/home-manager;
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";


  outputs = { self, nixpkgs, ... } @ inputs:
    let
      inherit (builtins) attrValues;


      forAllSystems = f: builtins.listToAttrs (map
          (name: { inherit name; value = f name; })
          (nixpkgs.lib.platforms.all)
        );

      pkgs = forAllSystems (system: import nixpkgs {
        inherit system;
        lib = nixpkgs.lib;
        config.allowUnfree = true;
        overlays = attrValues self.overlays;
      });

      sys = nixpkgs.lib.mapAttrs'
        (k: v: {
          name = "sys/${k}";
          value = v.config.system.build.toplevel;
        })
        self.nixosConfigurations;

      usr = nixpkgs.lib.mapAttrs'
        (k: v: {
          name = "usr/${k}";
          value = v.activationPackage;
        })
        self.homeConfigurations;

    in {
      nixosModules = import ./sys/modules;
      nixosConfigurations = {
        laptop = self.lib.mkSystem "laptop" "x86_64-linux"  nixpkgs (with self.nixosModules; [
          fonts gnome nix packages services sound time virtualisation xserver
        ]);
        raspi  = self.lib.mkSystem "raspi"  "aarch64-linux" nixpkgs (with self.nixosModules; [
          fonts nix packages services sound time xfce xserver 
        ]);
      };

      homeModules = import ./usr/modules;
      homeConfigurations = {
        laptop = self.lib.mkHome "laptop" "x86_64-linux"  (with self.homeModules; [
          shell vscode
        ]);
        raspi  = self.lib.mkHome "raspi"  "aarch64-linux" (with self.homeModules; [
          shell
        ]);
      };

      lib = import ./lib inputs;
    
      overlays = {
        inputs = final: prev: { inherit inputs; };
        # emacs = emacs.overlay;
        # self = self.overlay;
      };

      packages = forAllSystems (system:
        with nixpkgs.legacyPackages.${system}; {

        } // sys // usr);

      apps = forAllSystems (system:
        with nixpkgs.legacyPackages.${system}; {
          switch = {
            type = "app";
            program = "${self.packages.${system}.switch-config}/bin/switch-config.sh";
          };
        });
    };
}
