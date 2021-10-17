{
  services = {
    printing.enable = true;
    openssh.enable = true;
    postgresql = {
      enable = true;
      enableTCPIP = true;
    };

    xrdp.enable = true;
  };
}