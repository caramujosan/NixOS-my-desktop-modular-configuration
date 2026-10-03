{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader e Filesystems
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "modprobe.blacklist=nouveau" "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

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
  console.keyMap = "br-abnt2";

  # Impressão e Nix
  services.printing.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true; 
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Usuário Principal do Sistema
  users.users."caramujosan" = {
    isNormalUser = true;
    description = "caramujosan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # =====================================================================
  # MÓDULOS DE SISTEMA ATIVADOS
  # =====================================================================
  meusModulos.system.gnome.enable = true;
  meusModulos.system.nvidia.enable = true;
  meusModulos.system.pipewire.enable = true;

  system.stateVersion = "26.05";
}
