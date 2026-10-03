{ pkgs, ... }:

{
  imports = [
    ../modules/user/default.nix
  ];

  home.username = "caramujosan";
  home.homeDirectory = "/home/caramujosan";
  home.stateVersion = "26.05";

  # Pacotes avulsos que não precisam de configurações complexas
  home.packages = with pkgs; [
    fastfetch
    gedit
    google-chrome
    htop
    keepassxc
    vscode
  ];

  programs.home-manager.enable = true;

  # =====================================================================
  # MÓDULOS DE USUÁRIO ATIVADOS
  # =====================================================================
  meusModulos.user.git.enable = true;
  meusModulos.user.bash.enable = true;
  meusModulos.user.vim.enable = true;
}
