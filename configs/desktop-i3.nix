# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

# network related optons

  networking.networkmanager.enable = true;

#Package configuration

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    terminator networkmanagerapplet zathura 
    gnome3.eog i3lock redshift cmus 
    shotwell xinput_calibrator 
    i3status xorg.xmodmap 
    lxappearance numix-gtk-theme arc-icon-theme gnome3.nautilus 
    ubuntu_font_family dmenu
    mutt vdirsyncer khal khard lynx keychain redshift 
  ];

  

### Hardware related settings
  hardware.sane.enable = true;
  hardware.pulseaudio.enable = true;

### Service related settings
  services = {
    cron.enable = true;
    udev.extraRules = ''
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE:="0666"
    '';
    printing.enable = true;

    xserver = {
      enable = true;
      layout = "us";
      windowManager.i3.enable = true;
      desktopManager = {
        xterm.enable = false;
        default = "none";
      };
#      windowManager.default = "i3";
#      displayManager = {
#        lightdm = {
#          enable  = true;
#          autoLogin = {
#            enable = true;
#            user = "vincent";
#            timeout = 0;
#          };
#        };
#      };
    };
    gnome3.gnome-keyring.enable = true;
  };

## User settings
#  users.extraUsers.vincent = {
#    isNormalUser = true;
#    uid = 1000;
#    extraGroups = [ "networkmanager" "wheel" "scanner" "vboxusers" "libvirtd" ];
#    shell = "/run/current-system/sw/bin/zsh";
#  };

}
