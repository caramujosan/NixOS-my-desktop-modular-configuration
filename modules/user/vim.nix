{ config, lib, ... }:

{
  options.myModules.user.vim.enable = lib.mkEnableOption "Vim configurado";
  
  config = lib.mkIf config.meusModulos.user.vim.enable {
    programs.vim = {
      enable = true;

      # Natively declarative options supported by Home Manager
      settings = {
        background = "dark";
        mouse = "a";
        number = true;
        relativenumber = true;
        ignorecase = true;
        smartcase = true;
        hidden = true;
        modeline = false;
        tabstop = 4;
      };

      # Raw VimL Script injected directly at the end of ~/.vimrc
      extraConfig = ''
        " Retorna o cursor para a última posição conhecida ao abrir um arquivo
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

        filetype plugin indent on
        set showcmd
        set showmatch
        set autowrite
        set wildmode=longest,list
        set hlg=pt    
        set ul=500     
        set ai          
        set hls          
        set incsearch

        " Highlight search 
        hi Search ctermbg=yellow ctermfg=black
        hi IncSearch ctermbg=yellow ctermfg=black

        " Mappings
        nnoremap n nzz
        nnoremap N Nzz
        nnoremap * *zz
        nnoremap # #zz
        nnoremap g* g*zz
        nnoremap g# g#zz
        nnoremap cs :let @/=""<cr>
      
        " Enable the ruler (shows line and column in the bottom right corner)
        set ruler
        hi StatusLine ctermfg=white
        set laststatus=2

        noremap <F2> :hi Comment ctermfg=black guifg=black<cr>
        noremap <F3> :hi Comment term=bold ctermfg=cyan guifg=cyan<cr>

        cab W w | cab Q q | cab Wq wq | cab wQ wq | cab WQ wq
        imap { {}<left>
        imap ( ()<left>
        imap [ []<left>

        au BufWritePost *.sh  !chmod +x %

        au FileType sh let b:is_bash=1

        syn case ignore
        syn keyword p_c caramujosan
        hi p_c ctermbg=white ctermfg=black

        autocmd BufWinLeave *.* mkview
        autocmd BufWinEnter *.* silent loadview

        syntax on
      ''
      # extraConfig = builtins.readFile ../../dotfiles/my_vimrc;
      ;
    };  
  };
}
