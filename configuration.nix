{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Virtualization
  # virtualisation = {
  #   libvirtd = {
  #     enable = true;
  #     qemu.ovmf.enable = true;
  #   };
  #   spiceUSBRedirection.enable = true;
  # };
  # programs.virt-manager.enable = true;
  
  # System
  networking.hostName = "lachrymal-abg"; # Define your hostname.
  time.timeZone = "America/Toronto";

  # Networking
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "ja_JP.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  nixpkgs.config.allowUnfree= true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # XDG Portal
  xdg.portal.enable = true;

  # KDE
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      extraPackages = with pkgs.kdePackages; [ sddm-kcm ];
  };
  # services.xserver.excludePackages = with pkgs; [ xterm ];
  services.desktopManager.plasma6.enable = true;
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  # GNOME
  # services.xserver = {
  #  enable = true;
  #  displayManager.gdm.enable = true;
  #  desktopManager.gnome.enable = true;
  #  excludePackages = with pkgs; [
  #    xterm
  #  ];
  # };
  # environment.gnome.excludePackages = with pkgs; [
  #   gnome.totem
  #   gnome-tour
  #   gnome.cheese
  #   gnome.geary
  #   gnome.gnome-music
  #   gnome.yelp
  #   gnome.gnome-contacts
  #   gnome.gnome-initial-setup
  #   epiphany
  #   gnome.simple-scan
  #   gnome.gnome-calculator
  #   gnome.gnome-maps
  #   gedit
  # ];
  # programs.dconf.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    victor-mono
    lmodern
    lmmath
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound
  sound.enable = true;
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

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      kdePackages.fcitx5-configtool
      fcitx5-mozc
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-lua
      kdePackages.fcitx5-chinese-addons
    ];
    fcitx5.waylandFrontend = true;
  };

  users.users.lach = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    wget

    pciutils
    python3
    ruff-lsp
    clang
    clang-tools
    gnumake
    valgrind
    lldb
    nil

    nodejs
    typescript
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
  # services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11";
}

