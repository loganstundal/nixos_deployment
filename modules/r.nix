{ config, pkgs, lib, ... }:

with pkgs;
let
  rstudio-packages = rstudioWrapper.override{ packages = with rPackages; [
    janitor
    devtools
    gridExtra
    knitr
    markdown
    rgdal
    rgeos 
    rgl
    rmarkdown
    sf
    shiny
    spdep
    testthat
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
    ];
    variables = {
      R_ENVIRON_USER = "~/.config/r/Renviron.logan";
      R_PROFILE_USER = "~/.config/r/Rprofile.logan";
      R_LIBS_USER    = "~/.config/r/Rlibrary.logan";
    };
  };
}
