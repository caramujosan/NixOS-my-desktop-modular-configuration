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
        "com.github.vkohaupt.vokoscreenNG"
      ];
    };
  };
}
