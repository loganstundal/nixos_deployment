{ config, pkgs, ... }:

{
  home.packages = with pkgs.gnomeExtensions; [
      #applications-menu # never worked and arcmenu looks nicer
      arcmenu
      clipboard-history
      dash-to-panel
      #sound-output-device-chooser
      space-bar
      tray-icons-reloaded
      user-themes
      vitals
  ];

}
