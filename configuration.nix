# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let 
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/x1/9th-gen>
      ./hardware-configuration.nix
      ./nixosModules
    ];

  hyprlandwm.enable = true;
  # i3wm.enable = true;

  # Bootloader.
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-c29e793a-e5c5-4c07-8691-f191d8f1c23d".device = "/dev/disk/by-uuid/c29e793a-e5c5-4c07-8691-f191d8f1c23d";
  networking.hostName = "triggerp"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  environment.pathsToLink = [ "/libexec" "/etc/dbus-1" "/share/dbus-1" ]; # links /libexec from derivations to /run/current-system/sw

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      mesa_drivers
      intel-ocl
      beignet
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];    
  };

  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.triggerp = {
    isNormalUser = true;
    description = "theo";
    extraGroups = [ "networkmanager" "video" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
     vim
     wget
     emacs29
     firefox
     gnumake
     gcc
     alacritty
     xfce.ristretto
     neofetch
     htop
     feh
     lxappearance
     git
     home-manager
     zsh
     zsh-powerlevel10k
     thefuck
     (python311.withPackages(ps: with ps; [ numpy pytest pip jupyter jupyter-core virtualenv setuptools ]))
     bluez
     spotify
     rofi
     unzip
     zip
     brightnessctl
     discord
     maim
     xclip
     copyq
     xsel
     bear
     lm_sensors
     polybarFull
     pywal
     calc
     networkmanager_dmenu
     material-icons
     mpd
     killall
     clang
     steam
     qt6.qt5compat
     help2man
     man-pages
     man-pages-posix
     pstree
     tree
     imgbrd-grabber
     xlockmore
     mpd
     pavucontrol
     netplan
     ocaml
     ocamlPackages.merlin
     ocamlPackages.ocaml-lsp
     ocamlPackages.ocamlformat
     gnat
     clang-tools
     graphviz
     cling
     go
     libreoffice-qt
     grim
     slurp
     zoxide
     fzf
     vlc
     inotify-tools
     obsidian
     appimage-run
     xdg-desktop-portal
     xdg-desktop-portal-hyprland
     xdg-desktop-portal-gtk
     xorg.libX11
     libGL
     bat
     inetutils
     gf
     aflplusplus
     unstable.pls
     cargo
     boost
     qemu
     multimarkdown
     xwaylandvideobridge
     google-chrome
     webcord
     xdg-utils
     wl-clipboard
     jq
     termshot
     cmake
     nodejs_21
     yarn
     krb5
     sshfs
     jetbrains.pycharm-professional
     jupyter
     docker

     # hyprland
     kitty
     dunst
     qt6.qtwayland
     wofi
     mesa
     mesa.dev
     mesa.driversdev
     wayland-protocols
     cairo
     libdrm
     pango
     libxkbcommon
     pam
     hyprland.dev
     pkg-config
     file
     swaylock
     unstable.waybar
     hyprpaper
     # hyprland
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];


  fonts.packages = with pkgs; [
     jetbrains-mono
     iosevka
     meslo-lgs-nf
     font-awesome
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

  services.blueman.enable = true;  
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  services.dbus.packages = [
    pkgs.dbus.out
    config.system.path
  ];

  fonts.fontDir.enable = true;

  documentation = {
    dev.enable = true;
    man.man-db.enable = false;
    man.mandoc.enable = true;
  };

  # xinput --set-prop 26 329 <sens> # mouse sensitivity
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.light.enable = true;


  # added for obsidian but does not resolve the problem
  # xdg.portal.enable = true;
  # xdg.portal.xdgOpenUsePortal = true;
  # xdg.portal.extraPortals = [
  #   pkgs.xdg-desktop-portal-hyprland
  # ];
  # xdg.portal.config.common.default = [ "hyprland" ];

  security.pam.services.swaylock = {};

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.hyprland}/bin/Hyprland";
  #       user = "triggerp";
  #     };
  #   };
  # };

}
