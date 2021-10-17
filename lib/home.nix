{ home-manager, ... } @ inputs:

host: system: modules: 
let 
  args = {
    inherit inputs;
  };

  username = "iknv";

in home-manager.lib.homeManagerConfiguration {
  inherit username;
  inherit system;

  homeDirectory = "/home/${username}";
  configuration = {
    _module = { inherit args; };

    nixpkgs = {
      overlays = builtins.attrValues inputs.self.overlays;
      config.allowUnfree = true;
    };

    imports = [ (./. + "/../usr/hosts/${host}.nix") ] ++ modules;
  };
}