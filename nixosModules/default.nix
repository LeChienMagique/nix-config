{pkgs, lib, config, ...}: {
  imports = [
    ./windowManagers/hyprlandwm.nix
    ./windowManagers/i3wm.nix
  ];
}
