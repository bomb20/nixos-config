# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7935529f-f202-465f-be65-b08f91a5ac62";
      fsType = "btrfs";
      options = [ "subvol=@nixos" ];
    };

  boot.initrd.luks.devices."luksroot".device = "/dev/disk/by-uuid/4c38f469-994d-4ea4-8c0a-941f27df952e";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/7935529f-f202-465f-be65-b08f91a5ac62";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/home/.snapshots" =
    { device = "/dev/disk/by-uuid/7935529f-f202-465f-be65-b08f91a5ac62";
      fsType = "btrfs";
      options = [ "subvol=@snapshots/home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/54F4-38B1";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
#  powerManagement.cpuFreqGovernor = "powersave";
}