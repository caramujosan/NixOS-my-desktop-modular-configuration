{ config, lib, pkgs, ... }:

{
  options.myModules.system.hyprland.enable = lib.mkEnableOption "Hyprland Wayland Compositor";

  config = lib.mkIf config.myModules.system.hyprland.enable {
    programs.hyprland = {
      # Enables Hyprland on the system (required for polkit permissions, etc.)
      enable = true;
      
      #uwsm.enable = true;
      withUWSM = true;
      
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      
      # Optional: If you use an Nvidia card, enable this to optimize Hyprland on Wayland.
      xwayland.enable = true;
    
    };

    
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    
    # ESSENTIAL environment variables for Hyprland with Nvidia
    #environment.sessionVariables = {
     #WLR_NO_HARDWARE_CURSORS = "1"; # Evita o cursor invisível/bugado
     #NIXOS_OZONE_WL = "1";          # Força apps Electron (como VS Code) a usarem Wayland nativo
    #};

    environment.systemPackages = with pkgs; [
      # Essential basic tools for a clean WM
      kitty         
      rofi  
      waybar        
      dunst         
      awww        
    ];

    # Configures SDDM (Wayland-compatible display manager) instead of GDM
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
