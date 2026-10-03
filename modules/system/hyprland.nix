{ config, lib, pkgs, ... }:

{
  options.myModules.system.hyprland.enable = lib.mkEnableOption "Hyprland Wayland Compositor";

  config = lib.mkIf config.myModules.system.hyprland.enable {
    # Enables Hyprland on the system (required for polkit permissions, etc.)
    programs.hyprland.enable = true;

    # Optional: If you use an Nvidia card, enable this to optimize Hyprland on Wayland.
    programs.hyprland.xwayland.enable = true;

    environment.systemPackages = with pkgs; [
      # Essential basic tools for a clean WM
      kitty         
      rofi  
      waybar        
      dunst         
      swww        
    ];

    # Configures SDDM (Wayland-compatible display manager) instead of GDM
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
