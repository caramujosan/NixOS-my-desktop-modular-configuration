{ config, lib, ... }:

{
  options.myModules.user.flatpak.enable = lib.mkEnableOption "User-scope Flatpak";

  config = lib.mkIf config.myModules.user.flatpak.enable {
    services.flatpak = {
      enable = true;
      
      # Flathub Repo
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];

      # User Packages
      packages = [
        "com.github.tchx84.Flatseal"
      ];

      # Weekly automatic updates via systemd timer (optional)
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };

      # Automatically uninstalls Flatpaks installed manually via CLI that are not in this list (optional)
      #uninstallUnmanaged = true;
    };
  };
}
