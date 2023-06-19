{
  description = "My NixOS setup";

  inputs = 
    {
    # inputs ~ essentially, the attribute sets of all dependencies used in the flake.
    # these are what are used to build what emerge from the outputs block during system build
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };



  outputs = inputs @ { self,  nixpkgs,  home-manager, ... }: 
    let
      user      = "logan";
      system    = "x86_64-linux";
      pkgs      = import nixpkgs {
        inherit system;  # inherit (useful when the object equals desired output; ie want x86_64-linux here)
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in 
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs user system home-manager;
        }
      );
    };
}
