{ pkgs, lib, config, inputs, ...}: {
  options = {
    hyprlandwm.enable = lib.mkEnableOption "enables hyprland wm";
  };

  config = lib.mkIf config.hyprlandwm.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

  };
}
