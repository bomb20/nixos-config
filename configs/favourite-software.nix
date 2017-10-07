
{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget vim rsync git firefox borgbackup sudo vlc gnupg zim hexchat
    gcc gnumake cmake maven subversion sshfs-fuse gimp calibre liferea tdesktop pv 
    nextcloud-client texmaker pass python3 octave xsane htop arp-scan 
    usbutils hplipWithPlugin darcs ghc vimPlugins.ghc-mod-vim jetbrains.idea-community 
    jetbrains.pycharm-community openjdk tor-browser-bundle-bin 
    syncthing libreoffice
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

}
