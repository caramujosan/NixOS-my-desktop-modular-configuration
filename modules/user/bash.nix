{ config, lib, pkgs, ... }:

{ 
  options.myModules.user.bash.enable = lib.mkEnableOption "Integrated Bash and Direnv"; 

  config = lib.mkIf config.myModules.user.bash.enable { 
    home.packages = with pkgs; [ direnv nix-direnv ]; 

    programs.direnv = { 
      enable = true; 
      nix-direnv.enable = true; 
      enableBashIntegration = true; 
    }; 

    programs.bash = { 
      enable = true; 
      shellAliases = { 
        ll="ls -alF"
        la="ls -A"
        l="ls -CF"
        rm="rm -iv"
        cp="cp -iv"
        mv="mv -iv"
      }; 

      # The path goes back 2 folders: user/ -> modules/ -> dotfiles/ 
      initExtra = builtins.readFile ../../dotfiles/my_bashrc; 
    }; 
  };
}
