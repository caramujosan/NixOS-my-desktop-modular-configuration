{ config, lib, pkgs, ... }:

{
  options.myModules.system.hyprland.enable = lib.mkEnableOption "Hyprland Wayland Compositor";

  config = lib.mkIf config.myModules.system.hyprland.enable {
    programs.hyprland = {
      # Enables Hyprland on the system (required for polkit permissions, etc.)
      enable = true;
      withUWSM = true;
      # Optional: If you use an Nvidia card, enable this to optimize Hyprland on Wayland.
      xwayland.enable = true;
    };

    # Enables basic graphics support for Wayland acceleration.
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    
    environment.systemPackages = with pkgs; [
      kitty         
      rofi  
      waybar        
      dunst         
      awww        
    ];

    # ESSENTIAL environment variables for Hyprland with Nvidia
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    # Replacing SDDM with GDM (significantly more stable for Wayland + Nvidia)
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    
    # Configures SDDM (Wayland-compatible display manager) instead of GDM
    #services.displayManager.sddm = {
      #enable = true;
      #wayland.enable = true;
    #};
    
  };
}
