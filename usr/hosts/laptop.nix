{ config, pkgs, ... }:

let
  py-packages = pkgs.python39.withPackages(py: with py; [
    bpython
    requests
  ]);

  hs-packages = pkgs.haskellPackages.ghcWithHoogle(hs: with hs; [
    hlint
    haskell-language-server
    brittany
    cabal-install

    xmonad
    xmonad-contrib
    xmonad-extras
    xmobar
  ]);

  gnome-ext = with pkgs; [
    gnome.ghex
    gnome.gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-plank plank
    gnomeExtensions.just-perfection
  ];

in {
  programs.home-manager.enable = true;
  

  home.packages = with pkgs; [
    hs-packages
    py-packages

    niv nox
    
    android-tools
    scrcpy
    
    brave
    emacs
    kitty
    
    tmux
    cava
    
    libreoffice
    virt-manager

    spotify
    # inputs.self.packettracer
    discord
    betterdiscordctl
  ];
}
