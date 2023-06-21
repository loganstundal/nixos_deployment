{ config, pkgs, ... }:

with pkgs;
# likely failing to a directory issue (error 127). likely wants to go home/logan
# help: discourse.nixos.org/t/is-there-a-way-to-add-r-packages-straight-from-github/17871/2
#  INLA = stdenv.mkDerivation {
#    name = "INLA";
#    src = pkgs.fetchFromGitHub {
#      owner = "hrue";
#      repo  = "r-inla";
#      rev   = "a44bbf3b7f506e984190c2329a5398af78613ca0";
#      sha256 = "/5yjilKpfcB6VuljB2YdQqhsvjn/VhnQTyBh63CANyw=";
#    };
#  };
let
  rstudio-packages = rstudioWrapper.override{ packages = with rPackages; [
    janitor
    Deriv
    Ecdat
    HKprocess
    MatrixModels
    Rgraphviz
    deldir
    devtools
    doParallel
    dplyr
    evd
    fields
    ggplot2
    gsl
    graph
    gridExtra
    knitr
    markdown
    matrixStats
    mlogit
    mvtnorm
    numDeriv
    pixmap
    rgl
    rmarkdown
    sf
    shiny
    sn
    spdep
    splancs
    terra
    tidyterra
    testthat
    INLAspacetime
    Matrix
    sp
    tidyverse
    rstan
  ]; };
in

{
  environment = {
    systemPackages = with pkgs; [ 
      rstudio-packages 
      R 
      mkl
    ];
    variables = {
      #R_ENVIRON      = "$(R RHOME)/etc/Renviron";
      #R_ENVIRON_USER = "~/.config/r/Renviron.logan";
      R_PROFILE_USER = "~/.config/r/Rprofile.logan";
      R_LIBS_USER    = "~/.config/r/Rlibrary.logan";
    };
  };
}
