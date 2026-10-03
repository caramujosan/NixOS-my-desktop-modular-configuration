{ config, lib, pkgs, ... }:

{
  options.myModules.user.development.enable = lib.mkEnableOption "Ferramentas de Desenvolvimento";

  config = lib.mkIf config.myModules.user.development.enable {
    
    # 1. General development packages
    home.packages = with pkgs; [
      # Languages ​​and Compilers
      #go
      #rustup
      python3
      kotlin
      #jdk17
      
      # Tools and Containers
      #gcc
      #gnumake
      direnv      # For local environments (e.g., with Flakes)
      #podman
      #podman-compose
      #devpod
      
      # Editors (if installed via Flatpak)
      vscode
      android-studio
      #jetbrains.rust-rover
    ];

    # 2. Bash integration for direnv (loads environment variables per directory)
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
