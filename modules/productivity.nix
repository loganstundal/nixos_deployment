{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    onlyoffice-bin
    zotero
  ];
}
