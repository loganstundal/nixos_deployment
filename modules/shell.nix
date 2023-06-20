{ config, pkgs, ... }:

{
  # ----------------------------------- #
  # programs
  # ----------------------------------- #
  programs = {
    # use zsh as preferred shell (made explicit in users (as I am the only user). config for zsh here
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "python" "man" ]; # see <github.com/unixorn/awesome-zsh-plugins#plugins> for MANY>
        theme = "robbyrussell";
      };
    };
  };
  # ----------------------------------- #

  # ----------------------------------- #
  # environment
  # ----------------------------------- #
  environment.systemPackages = with pkgs; [
    #alacritty
    zsh-powerlevel10k
    meslo-lgs-nf
  ];
  # ----------------------------------- #
}
