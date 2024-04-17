{ config, pkgs, lib, spicetify-nix, ... }:

{
  imports = [
    ./spicetify
  ];
  
  home.username = "lach";
  home.homeDirectory = "/home/lach";
  
  home.packages = with pkgs; [    
    armcord
    fastfetch
    ffmpeg-full
    firefox
    fish
    fsearch
    gimp
    inkscape-with-extensions
    jdk
    kdePackages.kdenlive
    krita
    mpv
    vlc
    obs-studio
    onedrive
    onedrivegui
    p7zip
    pandoc
    piper
    prismlauncher
    qq
    smplayer
    typst
    ungoogled-chromium
    yt-dlp

    texlive.combined.scheme-medium

    osu-lazer

    # hydrapaper
    # gnome.gnome-tweaks
    # gnome.adwaita-icon-theme
    # gnomeExtensions.appindicator
    # gnomeExtensions.xwayland-indicator
    # gnomeExtensions.weather-or-not
    # gnomeExtensions.wiggle
    # gnomeExtensions.media-controls
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.clipboard-history
    # gnomeExtensions.open-bar
    # gnomeExtensions.kimpanel
    # gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher
    # gnomeExtensions.tray-icons-reloaded
    # gnomeExtensions.burn-my-windows
    # gnomeExtensions.compiz-windows-effect
  ];

 # dconf.settings = {
 #   "org/gnome/wm/keybindings" = {
 #     switch-input-source = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
 #     switch-input-source-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
 #   };
 #    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
 #      binding = "<Ctrl><Alt>t";
 #      command = "kgx";
 #      name = "GNOME Console";
 #    };
 # };

  qt = {
    enable = true;
#    platformTheme.name = "adwaita";
#    style.name = "adwaita-dark";
  };
    
  programs.emacs.enable = true;
  
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}

