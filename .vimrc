set termguicolors
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
          silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

call plug#begin()

Plug 'rakr/vim-one'
Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}

call plug#end()

let g:airline_theme='one'
colorscheme one
set background=dark
set nofoldenable
imap <F5> <Esc>:w<CR>:!clear;python %<CR>
nmap <F5> <Esc>:w<CR>:!clear;python %<CR>
