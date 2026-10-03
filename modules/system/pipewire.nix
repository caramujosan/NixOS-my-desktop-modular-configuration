{ config, lib, ... }:

{
  options.myModules.system.pipewire.enable = lib.mkEnableOption "Servidor de Áudio Pipewire";

  config = lib.mkIf config.myModules.system.pipewire.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
