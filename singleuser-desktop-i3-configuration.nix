# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./device-config.nix
      ./hardware-configuration.nix
    ];

# Boot-related options


# network related optons

  networking.networkmanager.enable = true;

#Package configuration

  nixpkgs.config = {
    allowUnfree = true;
  };

#  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget vim terminator rsync git networkmanagerapplet firefox borgbackup sudo zathura vlc gnupg zim hexchat
    gcc gnumake cmake maven subversion sshfs-fuse xournal gimp gnome3.eog i3lock redshift calibre cmus liferea tdesktop pv 
    nextcloud-client texmaker pass python3 octave shotwell xsane xinput_calibrator htop arp-scan 
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

### Service related things

  # Enable CUPS to print documents.
  hardware.sane.enable = true;

  # just X11 things...

  hardware.pulseaudio.enable = true;
#  services.gnome3.gnome-keyring.enable = true;

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
      windowManager.default = "i3";
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.vincent = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" "scanner" "vboxusers" "libvirtd" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

}
