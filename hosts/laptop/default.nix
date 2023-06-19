{ pkgs, lib, user, ...}:

{

  imports = [(import ./hardware-configuration.nix)];

  # force S3 sleep mode. S3 = suspend-to-ram which best preserves battery
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  services = {
    xserver = {
      libinput = {  # enable trackpad - MOVE to laptop specific config for import in future ---------------
        enable = true;
        touchpad = {
          tapping = true;
          naturalScrolling = true;
          accelSpeed = "-0.5";
        };
      };
    };
    printing.enable = true; # enable CUPS to print documents (may be useful)
  };


}
