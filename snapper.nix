{ config, pkgs, ... }:
{
  services.snapper = {
    configs = {
      home = {
        subvolume = "/home";
        extraConfig = ''
          ALLOW_USERS="vincent"
          TIMELINE_CREATE="yes"
          TIMELINE_CLEANUP="yes"
          TIMELINE_LIMIT_HOURLY="12"
          TIMELINE_LIMIT_DAILY="7"
          TIMELINE_LIMIT_WEEKLY="4"
          TIMELINE_LIMIT_MONTHLY="6"
          TIMELINE_LIMIT_YEARLY="0"
        '';
       };
    };
  };
}
