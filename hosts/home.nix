# -------------------------------------------------------------------------------- #
# ~ home.nix
# -------------------------------------------------------------------------------- #
# 
# -------------------------------------------------------------------------------- #


# ----------------------------------- #
# Contents
# ----------------------------------- #
# 01. setup + variables
# 02. imports - installed packages declared in imports for modularity
# 03. home-manager declarations and packages
# 04. home-directory structure
# 05. dconf settings (interface customization and extensions)
# 06. theme setup via gtk
# ----------------------------------- #


# -------------------------------------------------------------------------------- #
# ----------------------------------- #
# 01. Setup and variables
# ----------------------------------- #
{ config, pkgs, ... }:
# ----------------------------------- #
{

  # ----------------------------------- #
  # 02. imports
  # ----------------------------------- #
  imports = [
    ../modules/extensions-gnome.nix
    ../modules/productivity.nix
    ../modules/gaming.nix
    ../modules/media.nix
  ];
  # ----------------------------------- #



  # ----------------------------------- #
  # 03. home-manager declarations and program config
  # ----------------------------------- #
  # Allow home manager to install (if necessary) and self-manage:
  programs.home-manager.enable = true;

  home = {
    # declarations
    username      = "logan";
    homeDirectory = "/home/logan";
    stateVersion  = "23.11";

    # main theme is broken in gnome 44 for most themes presently
    #sessionVariables.GTK_THEME = "Dracula";
  };

  # ---- git configuration
  programs.git = {
    enable    = true;
    userName  = "loganstundal";
    userEmail = "logan.stundal@gmail.com";
    extraConfig = { init = { defaultBranch = "main";};  };
  };
  # ----------------------------------- #


  # ----------------------------------- #
  # 04. home directory structure
  # ----------------------------------- #
  xdg.userDirs = {
   enable      = true;
   music       = null;
   pictures    = null;   
   publicShare = null;
   templates   = null;
   videos      = null;
  };
  # ----------------------------------- #


  # ----------------------------------- #
  # 05. dconf settings (interface customization and extensions)
  # ----------------------------------- #
  # Note: to figure out names execute: dconf watch /
  #       in a second terminal, make chances, and implement below.
  # see : hoverbear.org/blog/declarative-gnome-configuration-in-nixos/ for more guide

  dconf.settings = {
    # ---- dark-mode
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    # ---- workspace names
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [ "Main" ];
    };
    "org/gnome/shell/extensions/space-bar/behavior" = {
      show-empty-workspaces = false;
      #smart-workspace-names = true;
    };
    
    # ---- nautilus file manager behavior
    "org/gtk/gtk4/settings/file-chooser" = {
      directories-first = true;
      show-hidden       = false;
    };
    "org/gnome/nautilus" = {
      "preferences/default-folder-viewer" = "list-view";
      "list-view/default-zoom-level" = "small";
      "list-view/use-tree-view" = true;
      "window-state/initial-size" = ["800" "600"];
    };

    # ---- favorite apps (tray or bottom menu bar order)
    "org/gnome/shell" = {favorite-apps = [
      "org.gnome.Settings.desktop"
      "firefox.desktop"
      "org.gnome.Nautilus.desktop"
      "org.gnome.Console.desktop"
      "RStudio.desktop"
    ];};    

    # ---- dash-to-dock
    "org/gnome/shell/extensions/dash-to-panel" = {
       # hide "Show Applications" button - unneeded when arcmenu active 
       # cannot believe dumping this hot mess of a dictionary in here worked"
       "panel-element-positions" = ''
       {"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}
       '';      
      "panel-sizes"    = "{\"0\":32}"; # shrink panel thickness
    };

    # ---- user extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "arcmenu@arcmenu.com"
        "clipboard-history@alexsaveau.dev"
        "dash-to-panel@jderose9.github.com"
        #"sound-output-device-chooser@kgshank.net"
        "space-bar@luchrioh"
        "trayIconsReloaded@selfmade.pl"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
      ];
    };
  };
  # ----------------------------------- #


  # ----------------------------------- #
  # 06. theme setup via gtk
  # ----------------------------------- #
  gtk = {
    enable = false;

    # ---- main theme
    ## the main theme is all messed up on gnome 44 presently
    # theme = {
    #   name = "Dracula";
    #   package = pkgs.dracula-theme;
    # };

    # ---- icons
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # ---- cursor
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };
    
    # ---- extra config (prefer dark mode)
    # gtk3.extraConfig = {
    #   Settings = ''
    #     gtk-application-prefer-dark-theme=1
    #   '';
    # };

    # gtk4.extraConfig = {
    #   Settings = ''
    #     gtk-application-prefer-dark-theme=1
    #   '';
    # };
  };
}
# -------------------------------------------------------------------------------- #

