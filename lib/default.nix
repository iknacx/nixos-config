inputs:

{
  mkSystem = import ./system.nix { inherit inputs; };
  mkHome = import ./home.nix inputs;
}