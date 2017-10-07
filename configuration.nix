{ config, pkgs, ... }:

{
  imports = 
    [
      ./hardware-configuration.nix
      ./devices/x230t-specific.nix
      ./configs/desktop-i3.nix
      ./configs/snapper.nix
      ./configs/singleuser-autologin.nix
      ./configs/favourite-software.nix
#      ./configs/gnome3.nix
    ];

  services.xserver.windowManager.default = "i3";
}
