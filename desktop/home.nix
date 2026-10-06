{ pkgs, ... }:

{
  imports = [
    ../modules/user/default.nix
  ];

  home.username = "caramujosan";
  home.homeDirectory = "/home/caramujosan";
  home.stateVersion = "26.05";

  # Standalone packages that do not require complex configurations
  home.packages = with pkgs; [
    fastfetch
    gedit
    google-chrome
    htop
    keepassxc
    vokoscreen-ng
  ];

  programs.home-manager.enable = true;
  
 
 # =====================================================================
  # USER MODULES ACTIVATED
  # =====================================================================
  myModules.user.git.enable = true;
  myModules.user.bash.enable = true;
  myModules.user.vim.enable = true;
  myModules.user.development.enable = true;
}
