{
  services.xserver = {
    enable = true;
    layout = "latam,apl";
    xkbOptions = "grp:rctrl_switch";
    libinput.enable = true;
  };
}