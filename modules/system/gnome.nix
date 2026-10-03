{ config, lib, ... }:

{
  options.myModules.system.gnome.enable = lib.mkEnableOption "GNOME Desktop Environment";

  config = lib.mkIf config.myModules.system.gnome.enable {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.xserver.xkb = {
      layout = "br";
      variant = "";
    };
  };
}
