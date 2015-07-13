" vundle vundle vundle !
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vundle vroom vroom
Plugin 'gmarik/Vundle.vim'

" plugins!
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'pangloss/vim-javascript'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'
Plugin 'sjl/gundo.vim'

" more optional stuff
Plugin 'elzr/vim-json'
Plugin 'plasticboy/vim-markdown'

call vundle#end()            

" because its 2015
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_python_checkers = ['pylint']

" sometimes pep8 is too much
" C0103 - invalid constant name
let g:syntastic_python_pylint_arg = '--disable=C0103' 


filetype plugin indent on  
set t_Co=256
syntax on
colorscheme Tomorrow-Night-Eighties 

set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
set backspace=2
set autoindent
set smartindent
set ruler
set nu

" turn on airline
set laststatus=2
let g:airline_powerline_fonts = 1

set foldmethod=indent
set foldlevel=99

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" because who don't love copy pasta, bay bee !
set clipboard=unnamedplus,unnamed,autoselect

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

