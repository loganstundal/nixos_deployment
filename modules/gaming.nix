{ config, pkgs, ...}:

{
  home.packages = with pkgs; [
    lutris
    yuzu-early-access
  ];
}
