{ config, pkgs, lib, spicetify-nix, nixpkgs-2405, ... }:

{
  imports = [
    ./spicetify
  ];
  
  home.username = "lach";
  home.homeDirectory = "/home/lach";
  
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: _: {
      nixpkgs2405 = import nixpkgs-2405 {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config;
      };
    })
  ];

  home.packages = with pkgs; [
    xmousepasteblock
    fastfetch
    ffmpeg-full
    firefox
    fish
    fsearch
    gimp
    inkscape-with-extensions
#    jdk
    krita
    mpv
    vlc
    obs-studio
    nixpkgs2405.onedrive
    nixpkgs2405.onedrivegui
    p7zip
    pandoc
    piper
#    prismlauncher
    qq
    smplayer
    typst
#    ungoogled-chromium
    yt-dlp
#    davinci-resolve

    texlive.combined.scheme-medium

#    osu-lazer

    hydrapaper
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.xwayland-indicator
    gnomeExtensions.weather-or-not
#    gnomeExtensions.wiggle
    gnomeExtensions.media-controls
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-history
#    gnomeExtensions.open-bar
    gnomeExtensions.kimpanel
    gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher
#    gnomeExtensions.tray-icons-reloaded
#    gnomeExtensions.burn-my-windows
#    gnomeExtensions.compiz-windows-effect
    gnomeExtensions.quick-settings-tweaker
  ];

  dconf.settings = {
    "org/gnome/wm/keybindings" = {
      switch-input-source = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
      switch-input-source-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Ctrl><Alt>t";
      command = "alacritty";
      name = "Console";
    };
  };
 
  programs.vscode = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.98;
      font = {
        size = 12.0;

        bold = {
            family = "Victor Mono";
            style = "Bold";
        };
        
        bold_italic = {
          family = "Victor Mono";
          style = "Bold Italic";
        };
        
        italic = {
          family = "Victor Mono";
          style = "Italic";
        };

        normal = {
          family = "Victor Mono";
          style = "Regular";
        };  
      };
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      kdePackages.fcitx5-configtool
      fcitx5-mozc
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-lua
      fcitx5-rime
    ];
#    fcitx5.waylandFrontend = true;
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
