call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'alessandroyorba/alduin'
Plug 'owickstrom/vim-colors-paramount'
Plug 'arakashic/chromatica.nvim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'thirtythreeforty/lessspace.vim'

call plug#end()

syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

autocmd FileType cpp setlocal cinoptions+=L0
autocmd BufNewFile,BufRead *.json set ft=javascript

"autocmd BufNewFile,BufReadPost *.cpp let g:chromatica#enable_at_startup=1

set noerrorbells
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent

set backspace=indent,eol,start

set laststatus=0

set nrformats-=octal

"set ttimeout
"set ttimeoutlen=100
set nottimeout

set incsearch

set ruler
set wildmenu
set showcmd

set autoread
set number

set wrap linebreak nolist
set textwidth=0
set spell

augroup filetypedetect
    au BufRead,BufNewFile config set filetype=sh
augroup end

nnoremap <silent> \ :noh<CR>
nnoremap <silent> <C-\> :!g++ %; ./a.out<CR>
map <DEL> x

let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nmap <Leader>p "+p
vmap <Leader>y "+y

map j gj
map k gk
map 0 g0
map $ g$
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap : :<C-g>u

:command W w
:command Dash call SetFileTypeShell("zsh")

set undofile
set backup
set backupdir=~/.local/share/nvim/backup

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

let g:gruvbox_bold=0
let g:gruvbox_italic=0
let g:gruvbox_underline=0
let g:gruvbox_undercurl=0
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_contrast_light="soft"
let g:gruvbox_hls_cursor="orange"
set background=dark
colorscheme gruvbox
