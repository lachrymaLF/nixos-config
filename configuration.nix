{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # System
  networking.hostName = "lachrymal-abg"; # Define your hostname.
  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "ja_JP.UTF-8";

  nixpkgs.config.allowUnfree = true;

  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = with pkgs; [ xterm ];
  };
  programs.dconf.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    totem
    gnome-tour
    cheese
    geary
    gnome-music
    yelp
    gnome-contacts
    gnome-initial-setup
    epiphany
    simple-scan
    gnome-calculator
    gnome-maps
    gedit
    gnome-terminal
    gnome-console
    gnome-text-editor
  ];
  
  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      victor-mono
      lmodern
      lmmath
      wqy_zenhei
    ];
     fontDir.enable = true;
     fontconfig = {
       enable = true;
     };
  };
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  users.users.lach = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  environment.systemPackages = with pkgs; [
    (pkgs.vesktop.override { withMiddleClickScroll = true; })

    wget
    pciutils
    mg
  ];
#  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  nixpkgs.overlays = [    
    (import ./im-overlays.nix)
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config.credential.helper = "libsecret";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  # Samba
  services.samba = {
    package = pkgs.samba4Full;
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "security" = "user";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        "server smb encrypt" = "required";
        "server min protocol" = "SMB3_00";
      };
      DL = {
        path = "/run/media/lach/A0762DC8762DA050/Downloads";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "lach";
      };
      Anime = {
        path = "/run/media/lach/A0762DC8762DA050/Archive/Anime";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "lach";
      };      
    };
  };
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    enable = true;
    openFirewall = true;
  };
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  
  system.stateVersion = "24.05";
}
