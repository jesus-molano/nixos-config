# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  lib,
  inputs,
  system,
  config,
  pkgs,

  username,
  fullname,
  ...
}:

{
  imports = [
    ./gtk.nix
    ./appimage.nix
    ./nix.nix
    ./boilerplate.nix
    ./bootloader.nix
    ./env-vars.nix
  ];

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Atlantic/Canary";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${fullname}";
    extraGroups = ["networkmanager" "wheel" "video" "kvm"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #### Core Packages
    lld
    gcc
    glibc
    clang
    udev
    llvmPackages.bintools
    wget
    procps
    killall
    zip
    unzip
    bluez
    bluez-tools
    libnotify
    brightnessctl
    light
    xdg-desktop-portal
    xdg-utils
    pipewire
    wireplumber
    alsaLib
    pkgconfig

    #### Standard Packages
    networkmanager
    networkmanagerapplet
    fish
    git
    fzf
    vim
    tldr
    sox
    yad
    flatpak
    libsecret
    gnome.gnome-keyring
    ripgrep
    fd
    lazygit
    gdu
    bottom
    nodejs_20

    #### GTK
    gtk2
    gtk3
    gtk4

    #### QT
    #qtcreator
    qt5.qtwayland
    qt6.qtwayland
    qt6.qmake
    libsForQt5.qt5.qtwayland
    qt5ct

    #### My Packages
    helix
    neovim
    qutebrowser
    brave
    xfce.thunar
    kitty
    bat
    exa
    pavucontrol
    blueman
    #trash-cli
    ydotool
    cava
    neofetch
    cpufetch
    starship
    lolcat
    gimp
    transmission-gtk
    slurp
    gparted
    vlc
    mpv
    krabby
    zellij
    shellcheck
    thefuck
    gthumb
    cmatrix

    #### My Proprietary Packages
    discord
    steam
    spotify
    telegram-desktop
    stremio
    mailspring

    #### Xorg Stuff :-(
    ## Libraries
    xorg.libX11
    xorg.libXcursor
    ## Window Managers
    #awesome
    ## Desktop Environments
    #cinnamon.cinnamon-desktop
    ## Programs
    #nitrogen
    #picom
    #dunst
    #flameshot

    #### Programming Languages
    ## Rust
    #cargo
    #rustc
    #rust-analyzer
    ## Go
    #go
    ## R
    #(pkgs.rWrapper.override {
    #  packages = with pkgs.rPackages; [
    #    dplyr
    #    xts
    #    ggplot2
    #    reshape2
    #  ];
    #})
    #(pkgs.rstudioWrapper.override {
    #  packages = with pkgs.rPackages; [
    #    dplyr
    #    xts
    #    ggplot2
    #    reshape2

    #    rstudioapi
    #  ];
    #})

    #### Command Shells
    nushell

    #### Display Managers
    lightdm
    sddm
    gnome.gdm

    #### Hyprland Rice
    hyprland
    xwayland
    cliphist
    alacritty
    rofi-wayland
    swww
    swaynotificationcenter
    lxde.lxsession
    inputs.hyprwm-contrib.packages.${system}.grimblast
    gtklock
    eww-wayland
    xdg-desktop-portal-hyprland
  ];

  # Font stuff:
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    (nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode" "CascadiaCode"];})
  ];

  # GTKLock
  security.pam.services.gtklock = {};

  # Steam
  programs.steam.enable = true;

  ## Enable some shit:
  # Programs
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
  };

  # Services
  services.xserver = {
    layout = "es,us";
    xkbVariant = "";
    xkbOptions = "grp:win_space_toggle,caps:swapecape";
    enable = true;
    libinput.enable = true;
    displayManager.sddm = {
      enable = true;
    };
  };

  services.blueman.enable = true;
  services.flatpak.enable = true;
  ## ^

  # Xorg window managers:
  services.xserver.windowManager = {
    #awesome = {
    #  enable = true;
    #  luaModules = with pkgs.luaPackages; [
    #    luarocks
    #    luadbi-mysql
    #  ];
    #};
  };

  # Xorg desktop environments:
  services.xserver.desktopManager = {
    plasma5.enable = true;
  };

  # Home manager options
  home-manager.users.${username} = {
    programs.waybar = {
      enable = true;
      package = inputs.hyprland.packages.${system}.waybar-hyprland;
    };
  };

  # Package overlays:
  nixpkgs.overlays = [
    (self: super: {
    })
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

