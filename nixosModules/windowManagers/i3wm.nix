{ pkgs, lib, config, ...}: {
  options = {
    i3wm.enable = lib.mkEnableOption "enables i3 wm";
  };
  
  config = lib.mkIf config.i3wm.enable {
    services.xserver = {
      enable = true;
      desktopManager = {xterm.enable=true;};
      displayManager = {
        defaultSession = "none+i3";
      };
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          dmenu
          i3status
	        i3lock
	        i3blocks
        ];
      };
    };
  };
}
