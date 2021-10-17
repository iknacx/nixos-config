{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_rpi4;
  boot.kernelParams = [
    "8250.nr_uarts=1"
    "console=ttyAMA0,115200"
    "console=tty1"
  ];
  
  boot.loader = {
    raspberryPi = {
      enable = true;
      version = 4;
    };
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };
  
  networking = {
    hostName = "nixpi";
    networkmanager.enable = true;
  
    useDHCP = false;
    interfaces = {
      eth0.useDHCP = true;
      wlan0.useDHCP = true;
    };
  };

  hardware.enableRedistributableFirmware = true;
  
  users.defaultUserShell = pkgs.fish;
  users.users.iknv = {
    description = "Ignacio";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "21.11";
}
