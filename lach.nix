{ config, pkgs, lib, ... }:

{
  home.username = "lach";
  home.homeDirectory = "/home/lach";
  
  home.packages = with pkgs; [
    discord
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

    clang
    nil
    texlive.combined.scheme-medium

    osu-lazer


    gnome.gnome-tweaks
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnomeExtensions.xwayland-indicator
    gnomeExtensions.weather-or-not
    gnomeExtensions.wiggle
    gnomeExtensions.media-controls
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-history
    gnomeExtensions.open-bar
    gnomeExtensions.kimpanel
    gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher
    gnomeExtensions.tray-icons-reloaded
  ];

  dconf.settings = {
    "org/gnome/wm/keybindings" = {
      switch-input-source = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
      switch-input-source-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
    };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    #   binding = "<Ctrl><Alt>t";
    #   command = "kgx";
    #   name = "GNOME Console";
    # };
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  # xdg.desktopEntries = {
  #   discord = { 
  #     name = "Discord";
  #     exec = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime %U";
  #   };
  #   qq = {
  #     name = "QQ";
  #     exec = "qq --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime %U";
  #   };
  # };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}

