{ config, lib, pkgs, ... }:

{
  options.myModules.user.vscodium.enable = lib.mkEnableOption "VSCodium with extensions";

  config = lib.mkIf config.myModules.user.vscodium.enable {
    # 1. Changing programs.vscode to programs.vscodium
    programs.vscodium = {
      enable = false;  
      
      # 2. In the new structure, we use profiles.default to manage extensions and settings
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix                  # Nix language support
          ms-python.python              # Python support
          shd101wyy.markdown-preview-enhanced    # Markdown preview
        ];
        
        # settings.json configurations moved into the default profile
        userSettings = {
          "editor.fontSize" = 14;
          "editor.tabSize" = 4;
          "editor.insertSpaces" = true;
          "editor.formatOnSave" = true;
          "workbench.colorTheme" = "Default Dark Modern";
          "files.autoSave" = "afterDelay";
          "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
        
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
  };
}
