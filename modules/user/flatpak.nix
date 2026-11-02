{ config, lib, ... }:

{
  options.myModules.user.flatpak.enable = lib.mkEnableOption "Flatpak no escopo do usuário";

  config = lib.mkIf config.myModules.user.flatpak.enable {
    services.flatpak = {
      enable = true;
      
      # Garante o repositório Flathub
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];

      # Pacotes do usuário
      packages = [
        "com.github.tchx84.Flatseal"
      ];

      # Atualizações automáticas semanais via systemd timer (opcional)
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };

      # Desinstala automaticamente Flatpaks instalados manualmente via CLI que não estejam nesta lista (opcional)
      #uninstallUnmanaged = true;
    };
  };
}
