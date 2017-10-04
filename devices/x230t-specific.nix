{ config, pkgs, ... }:

{

# Boot-related options

  boot = {
    kernelModules = [ "acpi_call" ];
    kernelPackages = pkgs.linuxPackages_hardened;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

# network related optons

  networking.hostName = "hell"; # Define your hostname.


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

## Packages
  environment.systemPackages = [ pkgs.xournal ];

## Enable KVM-Host stuff
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.enableKVM = true;
  
### Service related things

  services = {
    tlp = {
      enable = true;
      extraConfig = ''
        START_CHARGE_THRESH_BAT0=75
        STOP_CHARGE_THRESH_BAT0=80
      '';
    };
  
    xserver = {
      libinput.enable = true;
      synaptics.enable = false;
      config = ''
          Section "InputClass"
            Identifier     "Enable libinput for TrackPoint"
            MatchIsPointer "on"
            Driver         "libinput"
          EndSection
        '';
      wacom.enable = true;
    };
  };
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";
}
