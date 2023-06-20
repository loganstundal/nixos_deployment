
# This may offer a solution to install r-inla
# code example from:
# https://discourse.nixos.org/t/installing-an-archive-tar-gz-zip-etc-to-a-fixed-location-on-nixos/28333/2


# the latest rinla can be downloaded from:
# https://inla.r-inla-download.org/R/stable/src/contrib/INLA_23.04.24.tar.gz

{ stdenv
, lib
, fetchzip
}:

stdenv.mkDerivation rec {
  pname = "vuetorrent";
  version = "1.5.7";

  src = fetchzip {
    url = "https://github.com/WDaan/VueTorrent/releases/download/v${version}/vuetorrent.zip";
    sha256 = "5REe5wtYnmkPnP5wroRbHbiEAqYXx8OHht0O79eVBjY=";
  };

  buildPhase = "";
  installPhase = ''
    mkdir -p $out
    mv public $out
  '';
}


# -----

# OR try using nix built-ins to install:
# https://nixos.org/manual/nix/stable/language/builtins.html?highlight=fetchtarball
# or fetchurl
