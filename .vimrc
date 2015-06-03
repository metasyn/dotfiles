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

" more optional stuff
Plugin 'elzr/vim-json'
Plugin 'plasticboy/vim-markdown'

call vundle#end()            

" because its 2015
let g:syntastic_python_python_exec = '/usr/local/bin/python3'


filetype plugin indent on  
set t_Co=256
syntax on
colorscheme Tomorrow-Night-Eighties 

set expandtab
set tabstop=4
set softtabstop=2
set shiftwidth=2
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
:imap jj <Esc>

" leader = space
let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
