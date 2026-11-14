{ config, lib, pkgs, ... }:

{
  options.myModules.user.vscodium.enable = lib.mkEnableOption "VSCodium with extensions";

  config = lib.mkIf config.myModules.user.vscodium.enable {
    programs.vscodium = {
      enable = true;    
        
      #mutableExtensionsDir = (removeAttrs config.programs.vscodium.profiles [ "default" ]) == { };
    
      # Optional, but recommended: Manage VSCodium extensions declaratively
      extensions = with pkgs.vscode-extensions; [
        # Examples of popular extensions:
        bbenoist.nix                    # Nix language support
        # eamodio.gitlens                 # Supercharged Git
        # redhat.java                     # Java support
        # fwcd.kotlin                     # Kotlin support
        ms-python.python                # Python support
        # rust-lang.rust-analyzer         # Rust support
        shd101wyy.markdown-preview-enhanced    # Markdown preview
      ];
      
      # Configurações do settings.json traduzidas para atributos Nix
      userSettings = {
        "editor.fontSize" = 14;
        "editor.tabSize" = 4;
        "editor.insertSpaces" = true;
        "editor.formatOnSave" = true;
        "workbench.colorTheme" = "Default Dark Modern";
        "files.autoSave" = "afterDelay";
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
      
        # Exemplo de configuração aninhada (como a de arquivos excluídos da busca)
          "files.exclude" = {
          "**/.git" = true;
          "**/.svn" = true;
          "**/.hg" = true;
          "**/CVS" = true;
          "**/.DS_Store" = true;
          "**/Thumbs.db" = true;
        };
      };   
    };
  };  
}
