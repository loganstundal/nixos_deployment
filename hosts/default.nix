

# admin

{ lib, inputs, system, home-manager, user, ... }:

{

  laptop = lib.nixosSystem {
    inherit system; 
    specialArgs = { inherit user inputs; };
    modules = [
      ./laptop
      ../modules/gnome.nix
      ../modules/shell.nix
      ../modules/r.nix
      ../modules/docker.nix  # specifically for rinla...
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs  = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ (import ./home.nix) ];
        };
      }
    ];
  };
}
