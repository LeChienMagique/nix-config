{ pkgs, lib, config, inputs, ...}: {
  home.stateVersion = "23.11";
  home.username = "triggerp";
  home.homeDirectory = "/home/triggerp";

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hyprland-plugins.packages."${pkgs.system}".hyprbars
   ];

    settings = {
      exec-once = [
        "~/.config/waybar/launch.sh"
        "hyprpaper"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "~/.config/hypr/reload-desktop-portals.sh"
      ];

      monitor=[
        "eDP-1, 1920x1200, 0, 1"
      ];

      "misc:focus_on_activate" = true;
      xwayland.use_nearest_neighbor = false;

      input = {
        kb_layout = "us";
        kb_options = "ctrl:nocaps";
        follow_mouse = 1;

        touchpad =  {
          natural_scroll = "yes";
          scroll_factor = 0.5;
        };

        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };


      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };


      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        # bezier = "myBezier, 0.7, 0, 0.84, 0";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 1, myBezier" ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      
      master.new_is_master = true;
      gestures.workspace_swipe = "off";
      misc.force_default_wallpaper = -1;

      windowrulev2 = [
        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
      ];

      "$mainMod" = "SUPER";
      bind = [
        "$mainMod SHIFT, O, exec, swaylock --config ~/.config/swaylock/config.conf "
        "$mainMod, Q, exec, kitty            "
        "$mainMod, C, killactive,            "
        "$mainMod, M, exit,                  "
        "$mainMod, E, exec, dolphin          "
        "$mainMod, V, togglefloating,        "
        "$mainMod, R, exec, rofi -show drun "
        "$mainMod SHIFT, R, exec, rofi -show run "
        "$mainMod, P, pseudo, # dwindle      "
        "$mainMod, J, togglesplit, # dwindle "
        "$mainMod, left, movefocus, l                     "
        "$mainMod, right, movefocus, r                    "
        "$mainMod, up, movefocus, u                       "
        "$mainMod, down, movefocus, d                     "
        "$mainMod, 1, workspace, 1                        "
        "$mainMod, 2, workspace, 2                        "
        "$mainMod, 3, workspace, 3                        "
        "$mainMod, 4, workspace, 4                        "
        "$mainMod, 5, workspace, 5                        "
        "$mainMod, 6, workspace, 6                        "
        "$mainMod, 7, workspace, 7                        "
        "$mainMod, 8, workspace, 8                        "
        "$mainMod, 9, workspace, 9                        "
        "$mainMod, 0, workspace, 10                       "
        "$mainMod SHIFT, 1, movetoworkspace, 1            "
        "$mainMod SHIFT, 2, movetoworkspace, 2            "
        "$mainMod SHIFT, 3, movetoworkspace, 3            "
        "$mainMod SHIFT, 4, movetoworkspace, 4            "
        "$mainMod SHIFT, 5, movetoworkspace, 5            "
        "$mainMod SHIFT, 6, movetoworkspace, 6            "
        "$mainMod SHIFT, 7, movetoworkspace, 7            "
        "$mainMod SHIFT, 8, movetoworkspace, 8            "
        "$mainMod SHIFT, 9, movetoworkspace, 9            "
        "$mainMod SHIFT, 0, movetoworkspace, 10           "
        "$mainMod, S, togglespecialworkspace, magic       "
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1             "
        "$mainMod, mouse_up, workspace, e-1               "
      ];
      binde = [
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
        "CTRL ,XF86MonBrightnessDown,exec,brightnessctl set 1%-"
        "CTRL ,XF86MonBrightnessUp,exec,brightnessctl set +1%"

        ",XF86AudioMute,exec,amixer set Master toggle"
        ",XF86AudioLowerVolume,exec,amixer set Master 5%- unmute"
        ",XF86AudioRaiseVolume,exec,amixer set Master 5%+ unmute"
        "CTRL ,XF86AudioLowerVolume,exec,amixer set Master 1%- unmute"
        "CTRL ,XF86AudioRaiseVolume,exec,amixer set Master 1%+ unmute"
      ];
      bindm = [ "$mainMod, mouse:272, movewindow" "$mainMod, mouse:273, resizewindow" ];
      
      workspace = [
        "1, monitor:DP-2, defaultName:Emacs, on-created-empty: emacs"
        "2, monitor:DP-2"
        "3, defaultName:Firefox, on-created-empty: firefox"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "6, monitor:DP-2"
        "7, monitor:DP-2"
        "8, monitor:DP-2, defaultName:Config"
        "0, defaultName:Discord, on-created-empty: webcord"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };

    initExtra = ''
      [[ ! -f ${/home/triggerp/.p10k.zsh} ]] || source ${/home/triggerp/.p10k.zsh}
      eval "$(zoxide init --cmd cd zsh)"
      export BAT_THEME="TwoDark"
      export PLS_CONFIG="~/.config/pls/pls.yml"
      alias ll="pls -d perm -d user -d size -d mtime"
      alias ls="ll -e '^\..*$'"
      alias l="ls"
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}
