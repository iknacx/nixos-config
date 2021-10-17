{ inputs, ... }:

name: system: nixpkgs: modules:
  nixpkgs.lib.nixosSystem ({
    inherit system;
    extraArgs = inputs;
    
    modules = [
      (./. + "/../sys/hosts/${name}/config.nix")
      (./. + "/../sys/hosts/${name}/hardware.nix")

      nixpkgs.nixosModules.notDetected
    ] ++ modules;
  })