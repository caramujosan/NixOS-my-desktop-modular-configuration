{ config, lib, ... }:

{
  options.myModules.system.nvidia.enable = lib.mkEnableOption "Drivers Proprietários NVIDIA";

  # Configuration for Nvidia with Gnome
  config = lib.mkIf config.myModules.system.nvidia.enable {
  
    # Load proprietary video drivers
    services.xserver.videoDrivers = [ "nvidia" ];
    
    # 1. Mandatory for Wayland/Gnome to work correctly.
    hardware.nvidia = {
      modesetting.enable = true;
      
      # 2. Fix scramble pixels. Force saving all VRAM on SSD/RAM before sleep.
      powerManagement.enable = true;

      # Opctional. Deactivate to use closed source traditional driver, BUT
      # open source Nvidia driver (Open Kernel Modules) works fine.
      open = true;
      
      nvidiaSettings = true;
      
      # Ensure the most recent stable package.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}

