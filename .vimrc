" vundle vundle vundle !
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vundle vroom vroom
Plugin 'gmarik/Vundle.vim'

" plugins!
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'

" more optional stuff
Plugin 'elzr/vim-json'
Plugin 'plasticboy/vim-markdown'

call vundle#end()            

filetype plugin indent on  
set t_Co=256
syntax on
colorscheme Tomorrow-Night-Eighties 

set expandtab
set textwidth=79
set tabstop=4
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set ruler

" turn on airline
set laststatus=2

set foldmethod=indent
set foldlevel=99

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

