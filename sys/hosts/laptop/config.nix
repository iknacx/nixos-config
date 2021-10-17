{ config, pkgs, ... }:

{
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = true;
    useOSProber = true;
    devices = [ "nodev" ];
  };
  boot.kernelParams = [ "pci=nomsi" ];
  boot.plymouth.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  
    useDHCP = false;
    interfaces = {
      wlp2s0.useDHCP = true;
      enp3s0.useDHCP = true;
    };
  
    firewall.enable = false;
  };

  users.defaultUserShell = pkgs.nushell;
  users.users.iknv = {
    description = "Ignacio";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "21.11";
}
