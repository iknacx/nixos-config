{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget bat fd ripgrep exa
    home-manager
    git git-crypt
    unzip
    busybox patchelf file
  ];
}
