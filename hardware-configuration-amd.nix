# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" "usb_storage" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [
    #"kvm"
    "kvm-amd"
    "wl"
    # "vfio_pci" "vfio_iommu_type1" "vfio"
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/37e07dcb-c3b1-4d65-bdb7-eb1fffce07a7";
      fsType = "btrfs";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/home";
      fsType = "btrfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2094-9C1E";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ebf64c8a-c34e-4ac7-b428-a2ec23906d27"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;


  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ amdvlk rocmPackages.clr.icd  ];
    extraPackages32 = with pkgs; [ amdvlk ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.opentabletdriver.enable = true;
  services.ratbagd.enable = true;

  
  # VFIO
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" ];
  # boot.extraModprobeConfig = "options vfio-pci ids=10de:1b06,10de:10ef"; 
  # boot.kernelParams = [ "video=efifb:off" ];
}
