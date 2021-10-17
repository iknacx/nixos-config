{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixUnstable;
    autoOptimiseStore = true;
    gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
    };

    extraOptions = ''
    experimental-features = nix-command flakes
    '';
  };
}