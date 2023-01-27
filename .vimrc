set relativenumber
set nobackup
set nowritebackup
set updatetime=500
set autoindent
set smartindent
set wrap
set expandtab
set tabstop=4
set shiftwidth=4
set fileencoding='utf-8'
set whichwrap="b,s,<,>,[,]"
set ignorecase
set hlsearch
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre *.json :%!jq .
autocmd BufWritePre dyno/*.py :%!python3 -m black .
autocmd BufWritePost tmux.conf :!tmux source-file ~/.config/tmux/tmux.conf

call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
call plug#end()

let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ["nerdtree"]
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_section_c_only_filename = 1
colorscheme dracula
