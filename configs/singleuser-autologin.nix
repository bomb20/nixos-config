{ config, pkgs, ... }:

{



  services = {
    cron.enable = true;
    udev.extraRules = ''
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE:="0666"
    '';
    printing.enable = true;

    xserver = {
      enable = true;
#      layout = "us";
      displayManager = {
        lightdm = {
          enable  = true;
          autoLogin = {
            enable = true;
            user = "vincent";
            timeout = 0;
          };
        };
      };
    };
  };

  users.extraUsers.vincent = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" "scanner" "vboxusers" "libvirtd" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

}
