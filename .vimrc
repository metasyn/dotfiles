" vundle vundle vundle !
set nocompatible
set encoding=utf-8
filetype plugin on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" pretty status line
Plugin 'vim-airline/vim-airline' " basic
Plugin 'vim-airline/vim-airline-themes' " pretty

" completion, syntax
Plugin 'valloric/youcompleteme'
Plugin 'w0rp/ale'

Plugin 'elzr/vim-json' " less quotes
Plugin 'plasticboy/vim-markdown' " syntax

Plugin 'mileszs/ack.vim' "Ack search
Plugin 'scrooloose/nerdtree'

Plugin 'terryma/vim-expand-region' " + / - in visual mode
Plugin 'terryma/vim-multiple-cursors' " C-n for multiple
Plugin 'Chiel92/vim-autoformat' " Eh

Plugin 'sjl/gundo.vim' "Under used
Plugin 'tpope/vim-fugitive' "Gblame etc.

" javascript
Plugin 'othree/yajs.vim'
Plugin 'pangloss/vim-javascript' 
Plugin 'maksimr/vim-jsbeautify'

call vundle#end()


" ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pylint'],
\}
let g:ale_python_pylint_options= '--rcfile ~/.pylint.rc'

" nerd tree
nnoremap <Leader>f :NERDTreeToggle<Enter>

" fzf
set rtp+=/usr/local/opt/fzf

filetype plugin indent on
set t_Co=256
syntax on
colorscheme Tomorrow-Night-Eighties

" laze
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" basics
set autochdir
set autoindent
set backspace=2
set expandtab
set nu
set ruler
set shiftwidth=4
set smartindent
set softtabstop=4
set tabstop=8
set foldmethod=indent
set foldlevel=99

" because who don't love copy pasta, bay bee !
set clipboard=unnamedplus,unnamed,autoselect

" turn on airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

" html 2 space
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab

" javascript / es6
au BufRead,BufNewFile *.es6 set ft=javascript
au BufRead,BufNewFile *.sbt set ft=scala





