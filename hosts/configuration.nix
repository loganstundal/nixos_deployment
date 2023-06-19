# -------------------------------------------------------------------------------- #
# ~ configuration.nix
# -------------------------------------------------------------------------------- #
# This is the main configuration file for my nix install. It provides specifications
# for base system settings such as user creation, networking, and base packages 
# always installed on the system.


# NixOS default message:
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
# -------------------------------------------------------------------------------- #


# ----------------------------------- #
# Contents
# ----------------------------------- #
# 01. setup and variables
# 02. imports | imports for configuration.nix include:
#    - ./hardware-configuration.nix
# 03. boot loader
# 04. user + internalization
# 05. networking + bluetooth + sound
# 06. automatic updates + garbage collection
# 07. base system packages + services
# 08. flakes
# 09. networked drives + filesystem
# 10. configuration.nix stateversion
# ----------------------------------- #


# -------------------------------------------------------------------------------- #
# ----------------------------------- #
# 01. Setup + variables
# ----------------------------------- #
{ config, pkgs, ... }:

let
  user_name = "logan";
in
# ----------------------------------- #
{
  # ----------------------------------- #
  # 02. imports
  # ----------------------------------- #
#  imports =
#    [ # Include the results of the hardware scan.
#      ./hardware-configuration.nix
#    ];
  # ----------------------------------- #  


  # ----------------------------------- #
  # 03. boot loader
  # ----------------------------------- #
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Use the latest linux kernel    

    loader = {
      systemd-boot.enable             = true; # use the systemd-boot efi boot loader
      systemd-boot.configurationLimit = 2;    # max number of generations to retain in boot menu
      efi.canTouchEfiVariables        = true;
      timeout                         = 2;    # timeout (seconds) until loader boots default
    }; 
  };
  # ----------------------------------- #


  # ----------------------------------- #
  # 04. user + internalization
  # ----------------------------------- #
  # ---- user
  users.users.${user_name} = {
    isNormalUser    = true;
    home            = "/home/${user_name}";
    extraGroups     = [ "wheel" "networkmanager" ]; # "wheel" to enable 'sudo' for user
    initialPassword = "password";                   # initial password for new installs
    shell           = pkgs.zsh;                     # preferred shell (must be present in programs{} chunk!)
  };

  # ---- internalization
  time.timeZone      = "America/New_York";      # system timezone
  i18n.defaultLocale = "en_US.UTF-8";           # default locale language for program messages, dates, etc
  # ----------------------------------- #


  # ----------------------------------- #
  # 05. networking + bluetooth + sound
  # ----------------------------------- #
  # ---- networking
  networking = {
    hostName = "logan-laptop";
    networkmanager.enable = true;
    firewall = {
      enable = true; # default but good to be explicit on this
    };
  };

  # ---- bluetooth
  hardware = {
    pulseaudio = {
      enable  = true;
      package = pkgs.pulseaudioFull;
      extraConfig = '' 
        load-module module-switch-on-connect
      '';
    };
    bluetooth = {
      enable = true;
      #hsphfpd.enable = true; # HSP & HFP daemons (enabling creates a conflict with wireplumber)
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  # ---- sound
  sound = {
    enable           = true;
    mediaKeys.enable = true;
  };
  # ----------------------------------- #


  # ----------------------------------- #
  # 06. automatic updates + garbage collection
  # ----------------------------------- #
  # ---- automatic updates
  system = {
    autoUpgrade = {
      enable      = true;
      allowReboot = true;
      channel     = "https://nixos.org/channels/nixos-unstable";
      rebootWindow = {    # when upgrades can be applied (default of "null" means anytime)
        lower = "01:00";
        upper = "05:00";
      };
    };
  };

  # ---- garbage collection
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 2d";
    };
  };
  # ----------------------------------- #
  

  # ----------------------------------- #
  # 07. base system packages + services
  # ----------------------------------- #
  # ---- remove xterm
  services.xserver.excludePackages = [ pkgs.xterm ];

  # ---- exclude nixos manual in installation files
  documentation.nixos.enable = false;

  # ---- allow packages with proprietary licenses
  nixpkgs.config.allowUnfree = true;

  # ---- base system packages  
  environment = {
    variables = {
      EDITOR   = "nano";      # I should learn vim and use "nvim"
      VISUAL   = "nano";
    };

    systemPackages = with pkgs; [ 
      _7zz
      bat
      curl
      firefox
      git  
      htop
      nano
      neofetch
      nextcloud-client
      qbittorrent
      quarto
      tree
      unrar
      unzip
      wget
    ];
  };

  # ---- services (packages automatically install)
  # -------- tailscale (vpn)
  services.tailscale = {
    package = pkgs.tailscale;
    enable  = true;
    useRoutingFeatures = "client"; # to use --exit-node flag
  };

  # ---- flatpaks
  services.flatpak.enable = true;

  # ---- disable askpass (graphical ssh password prompt, I cannot seem to paste long passwords in it)
  programs.ssh.enableAskPassword = false;
  # ----------------------------------- #


  # ----------------------------------- #  
  # 08. flakes
  # ----------------------------------- #  
  # Flakes easily failitate integrating home-manager into nixOS system build allowing my user 
  # profile to be fuilt together with the system via `nixos-rebuild`
  nix = {
    package      = pkgs.nixFlakes;
    extraOptions = "experimental-features = flakes nix-command";
  };
  # ----------------------------------- #  


  # ----------------------------------- #
  # 09. networked drives + filesystem
  # ----------------------------------- #
  # making this explicit here is better for portability
  #fileSystems."/" = {
  #  device = "/dev/disk/by-label/main";
  #  fsType = "ext4";
  #};
  # this should probably stay in hardware-configuration.nix
  # ----------------------------------- #


  # ----------------------------------- #
  # 10. configuration.nix stateversion
  # ----------------------------------- #
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  # ----------------------------------- #
}
# -------------------------------------------------------------------------------- #

