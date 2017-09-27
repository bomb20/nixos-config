# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    kernelModules = [ "acpi_call" ];
    kernelPackages = pkgs.linuxPackages_hardened;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "hell"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  #
  #


  nixpkgs.config = {
    allowUnfree = true;
#    packageOverrides = pkgs: {
#      jre = pkgs.oraclejre8;
#      jdk = pkgs.oraclejdk8;
#    };
  };

  services.cron.enable = true;
#  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget vim terminator rsync git networkmanagerapplet firefox borgbackup sudo zathura vlc gnupg zim hexchat
    gcc gnumake cmake maven subversion sshfs-fuse xournal gimp gnome3.eog i3lock redshift calibre cmus liferea tdesktop pv 
    owncloud-client netbeans texmaker pass python3 octave shotwell xsane xinput_calibrator htop arp-scan 
    usbutils hplipWithPlugin i3status xorg.xmodmap darcs ghc vimPlugins.ghc-mod-vim jetbrains.idea-community 
    jetbrains.pycharm-community openjdk lxappearance numix-gtk-theme arc-icon-theme gnome3.nautilus tor-browser-bundle-bin 
    ubuntu_font_family dmenu
mutt vdirsyncer khal khard lynx keychain redshift syncthing 
  ];

  
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

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.sane.enable = true;


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
