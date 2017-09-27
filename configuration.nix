# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

#Package configuration

  nixpkgs.config = {
    allowUnfree = true;
  };

#  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget vim terminator rsync git networkmanagerapplet firefox borgbackup sudo zathura vlc gnupg zim hexchat
    gcc gnumake cmake maven subversion sshfs-fuse xournal gimp gnome3.eog i3lock redshift calibre cmus liferea tdesktop pv 
    nextcloud-client netbeans texmaker pass python3 octave shotwell xsane xinput_calibrator htop arp-scan 
    usbutils hplipWithPlugin i3status xorg.xmodmap darcs ghc vimPlugins.ghc-mod-vim jetbrains.idea-community 
    jetbrains.pycharm-community openjdk lxappearance numix-gtk-theme arc-icon-theme gnome3.nautilus tor-browser-bundle-bin 
    ubuntu_font_family dmenu
mutt vdirsyncer khal khard lynx keychain redshift syncthing libreoffice
  ];

  
# Progran specific options
  programs = {
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        theme = "gentoo";
      };
    };
    ssh.startAgent = true;
    vim.defaultEditor = true;
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.enableKVM = true;
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

### Service related things

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.sane.enable = true;


  services.cron.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE:="0666"
  '';

  # just X11 things...
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.lightdm.enable  = true;
    windowManager.i3.enable = true;
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    windowManager.default = "i3";
    displayManager.lightdm.autoLogin.enable = true;
    displayManager.lightdm.autoLogin.user = "vincent";
    displayManager.lightdm.autoLogin.timeout = 0;
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

  hardware.pulseaudio.enable = true;
#  services.gnome3.gnome-keyring.enable = true;


  services.tlp = {
    enable = true;
    extraConfig = ''
      START_CHARGE_THRESH_BAT0=75
      STOP_CHARGE_THRESH_BAT0=80
    '';
  };

  services.snapper = {
    configs = {
      home = {
        subvolume = "/home";
        extraConfig = ''
          ALLOW_USERS="vincent"
          TIMELINE_CREATE="yes"
          TIMELINE_CLEANUP="yes"
        '';
       };
    };
  };
  # TOR stuff
#  services.tor = {
#    enable = true;
#    client.enable = true;
#  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.vincent = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" "scanner" "vboxusers" "libvirtd" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

}
