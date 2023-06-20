{ config, pkgs, ... }:

{
  home.packages = with pkgs.gnomeExtensions; [
      applications-menu
      clipboard-history
      dash-to-panel
      #sound-output-device-chooser
      space-bar
      tray-icons-reloaded
      user-themes
      vitals
  ];

}
