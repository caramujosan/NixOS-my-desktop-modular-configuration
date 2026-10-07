{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader and Filesystems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Deactivate Nouveau video driver to avoid conflict with Nvidia AND
  # ensure Nvidia video driver memory management
  boot.kernelParams = [ "modprobe.blacklist=nouveau" "nvidia.NVreg_PreserveVideoMemoryAllocations=1" "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
  
  # Feature known as Early KMS, forces the kernel to load the graphics driver during the early boot stage, ensuring that SDDM already has rendering resources ready for the mouse.
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # Network & Locale
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };
  
  # Força o teclado ABNT2 no X11/Wayland (afeta a tela de login)
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };
  

  # Configura o console (TTY) para o teclado BR
  console.keyMap = "br-abnt2";
  
  
  # Install firefox
  programs.firefox.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Replaces identical files in /nix/store with hard links to save inodes and disk space. 
  nix.settings.auto-optimise-store = true;
  
  # Automatic Nix garbage collection.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Primary System User
  users.users."caramujosan" = {
    isNormalUser = true;
    description = "caramujosan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # =====================================================================
  # SYSTEM MODULES ACTIVATED
  # =====================================================================
  myModules.system.nvidia.enable = true;
  myModules.system.pipewire.enable = true;
  myModules.system.zram.enable = true;
  # DEs and Window Managers
  myModules.system.gnome.enable = true;
  myModules.system.hyprland.enable = false;
  
  services.flatpak.enable = true;
  
  system.stateVersion = "26.05";
}
