{
  fonts = import ./fonts.nix;
  gnome = import ./gnome.nix;
  nix = import ./nix.nix;
  packages = import ./packages.nix;
  services = import ./services.nix;
  sound = import ./sound.nix;
  time = import ./time.nix;
  virtualisation = import ./virtualisation.nix;
  xfce = import ./xfce.nix;
  xserver = import ./xserver.nix;
}