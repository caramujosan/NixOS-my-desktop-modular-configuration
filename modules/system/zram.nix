{ config, lib, ... }:

{
  options.myModules.system.zram = {
    enable = lib.mkEnableOption "Enable compressed swap memory with ZRAM (zstd)";
  };

  config = lib.mkIf config.myModules.system.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 50;
    };
  };
}
