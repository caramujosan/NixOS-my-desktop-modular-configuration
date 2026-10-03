{ config, lib, pkgs, ... }:

{
  options.meusModulos.user.git.enable = lib.mkEnableOption "Controle de versão Git";

  config = lib.mkIf config.meusModulos.user.git.enable {
    programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user.name = "caramujosan";
        user.email = "gustavocjorge11@yahoo.com.br";
        alias = {
          lg = "log --oneline --graph --decorate";
        };
      };
    };
  };
}
