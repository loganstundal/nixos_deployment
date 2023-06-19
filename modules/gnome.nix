{ pkgs, ... }:

{

  services = {
    xserver = {
      enable = true; # enable the x11 windowing system
      layout = "us"; # keyboard layout

      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };

  environment = {
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      baobab            # disk usage analyzer
      gnome-connections # remote desktop client
      gnome.totem       # video player
      xterm
    ]) ++ (with pkgs.gnome; [
      cheese           # photo app
      gnome-music      # music player
      gnome-maps       # map app
      gnome-calendar   # calendar app
      simple-scan      # document scanner
      gnome-software   # software download center
      gnome-weather    # weather app
      gedit            # document editor
      epiphany         # web browser
      geary            # mail client
      gnome-characters # utility to find characters
      tali             # game - poker
      iagno            # game - reversi
      hitori           # game - hitory
      atomix           # game - atomix
      yelp             # help viewer
      gnome-contacts   # contacts app
      gnome-initial-setup  # initial setup app
      file-roller          # archive utility
      seahorse             # utility to manage encryption keys
      gnome-font-viewer    # utility to view system fonts
      #gnome-disk-utility  # udisks graphical front end
      #gnome-logs          # viewer for systemd journal
      #gnome-shell-extensions  # default extension manager (appears this cannot or should not be removed)
    ]);
    systemPackages = with pkgs; [
     gnome.gnome-tweaks
      gnome-extension-manager
     # gnome-menus # to use applications-menu extension (this doesnt fix shit)
      gnome.dconf-editor
    ];
   };
}
