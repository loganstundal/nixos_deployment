{ config, pkgs, ... }:

{
  home.packages = with pkgs.gnomeExtensions; [
      #applications-menu # never worked and arcmenu looks nicer
      arcmenu
      blur-my-shell
      clipboard-history
      custom-hot-corners-extended
      dash-to-panel
      openweather
      #sound-output-device-chooser
      space-bar
      tiling-assistant
      tray-icons-reloaded
      user-themes
      vitals
  ];
}
