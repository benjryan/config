call plug#begin()
  Plug 'morhetz/gruvbox'
call plug#end()

"set path+=**
"set path+=/c/Program\\\ Files\\\ (x86)/Windows\\\ Kits/10/Include/**
"set path+=/c/Program\\\ Files\\\ (x86)/Microsoft\\\ Visual\\\ Studio/2019/Community/VC/Tools/MSVC/14.29.30133/include/**

" indent
set cino=:0,l1,(0,W4

set backspace=indent,eol,start

" netrw
let g:netrw_winsize=30
let g:netrw_banner=0
let g:netrw_preview=1
let g:netrw_liststyle=0
let g:netrw_alto=0
let g:netrw_altv=0
let g:netrw_fastbrowse=2
nnoremap <c-n> :Lex<CR>

" vimgrep
"let gpath='**' " override this when searching with particular filters
"nnoremap <c-p> :execute 'vim /' . expand('<cword>') . '/gj ' . gpath<CR>
nnoremap <c-p> :execute 'grep -r ' . expand('<cword>') . ' *'<CR>

" shell
set shell=cmd

" disable swap files
set noswapfile

" disable vim visual bell
set visualbell
set t_vb=
set belloff=all

" files
set encoding=utf-8
scriptencoding utf-8

" colorscheme
set background=dark
set termguicolors
colorscheme gruvbox

" spaces ftw
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" escape from terminal mode
"tnoremap <Esc> <C-\><C-n>

" highlight searches
set is hlsearch

" remove highlight after searching
nnoremap <Esc> :noh<CR>

nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap <c-q><c-q> :copen<CR>
nnoremap <c-q><c-w> :cclose<CR>

" line numbers
set number

" wrap
set wrap
set linebreak

" list chars
set nolist
set listchars=tab:>-,lead:·,trail:·,extends:>,precedes:<,nbsp:␣,eol:→
set showbreak=↪

" can't get these tabs and buffers binds to work
" tabs
"nnoremap <c-k> gt
"nnoremap <c-j> gT
"nnoremap <c-w> :tabclose<CR>

" buffers
"nnoremap <c-h> :bp<CR>
"nnoremap <c-l> :bn<CR>

" avoid freeze
nnoremap <c-z> <nop>

" allow mouse
set mouse=

" fix mouse click and drag
set ttymouse=sgr

" windows
set splitright
set splitbelow
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" allow switching between unsaved buffers
set hidden

set wildmenu
"set wildignorecase
"set wildmode=list:full

" cursor
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)
