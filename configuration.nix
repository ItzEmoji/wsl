{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.nvim.packages.${pkgs.system}.default
    vim
    git
    gnumake
    gcc
    ncurses
    fastfetch
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  wsl.enable = true;
  wsl.defaultUser = "cyril";
 
  system.stateVersion = "25.05"; 
}
