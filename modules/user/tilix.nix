{ config, lib, pkgs, ... }:

{
  options.myModules.user.tilix.enable = lib.mkEnableOption "Tilix terminal emulator";

  # Garante que o pacote Tilix está instalado para o usuário
  config = lib.mkIf config.myModules.user.tilix.enable {
  
    home.packages = [ pkgs.tilix ];

    # Converte o seu JSON de cores diretamente para o formato dconf do Home Manager
    dconf.settings = {
      "com/gnumake/tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d" = {
        name = "Tilix_terminal_configuration-2";
        visible-name = "Tilix_terminal_configuration-3";
        background-color = "#1C1C1F";
        badge-color = "#AC7EA8";
        bold-color = "#3584E4";
        cursor-background-color = "#000000";
        cursor-foreground-color = "#FFFFFF";
        foreground-color = "#FAF9F9";
        highlight-background-color = "#000000";
        highlight-foreground-color = "#FFFFFF";
        palette = [
          "#2E3436" "#E01B24" "#2EC27E" "#F5C110"
          "#51A1FF" "#75507B" "#4FD1FD" "#D3D7CF"
          "#555753" "#EA2828" "#4BE482" "#FCE94F"
          "#51A1FF" "#AD7FA8" "#4FD1FD" "#EEEEEC"
        ];
        use-badge-color = false;
        use-bold-color = false;
        use-cursor-color = false;
        use-highlight-color = false;
        use-theme-colors = false;
      };

      # Define o perfil acima como o perfil padrão do Tilix
      "com/gnumake/tilix" = {
        default-profile = "2b7c4080-0ddd-46c5-8f23-563fd3ba789d";
      };
    };
  };
}
