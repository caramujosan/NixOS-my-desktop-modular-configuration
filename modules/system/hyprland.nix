{ config, lib, pkgs, ... }:

{
  options.myModules.system.hyprland.enable = lib.mkEnableOption "Hyprland Wayland Compositor";

  config = lib.mkIf config.myModules.system.hyprland.enable {
    programs.hyprland = {
      # Enables Hyprland on the system (required for polkit permissions, etc.)
      enable = true;
      withUWSM = false;
      # Optional: If you use an Nvidia card, enable this to optimize Hyprland on Wayland.
      xwayland.enable = true;
    };
    
    # ESSENTIAL environment variables for Hyprland with Nvidia
    environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      #GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
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
      greetd.tuigreet
    ];

    # Display Managers - GDM, SDDM, Greet
    services.xserver.enable = true;
    services.displayManager.gdm.enable = false;
    services.displayManager.sddm = {
      enable = false;
      wayland.enable = false;
    };
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd 'Hyprland'";
          user = "greeter";
        };
      };
    };

  
  };
}
