{ config, lib, pkgs, ... }:

{
  options.myModules.user.git.enable = lib.mkEnableOption "Controle de versão Git";

  config = lib.mkIf config.myModules.user.git.enable {
    programs.git = {
      enable = true;
      
      # Global .gitignore
      ignores = [
        # --- direnv / nix-direnv ---
        ".direnv/"
        ".envrc.local"
        ".envrc.override"

        # Editors
        .vscode

        # --- OS and temp files ---
        "*~"
        "*.swo"
        "*.swp"
        ".DS_Store"
      ];
    
      settings = {
        init.defaultBranch = "main";
        user.name = "caramujosan";
        user.email = "gustavocjorge11@yahoo.com.br";
        alias = {
          lg = "log --oneline --graph --decorate";
          st = "status";
          cm = "commit -m";
        };
      };
    };
  };
}
