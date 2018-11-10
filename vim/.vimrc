set nocompatible
set encoding=utf-8
filetype plugin on

" if you don't have plug, you need to run
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

" pretty status line
Plug 'vim-airline/vim-airline' " basic
Plug 'vim-airline/vim-airline-themes' " pretty

" completion, syntax
" Plug 'valloric/youcompleteme'
Plug 'w0rp/ale'
Plug 'kien/ctrlp.vim'

Plug 'elzr/vim-json' " less quotes
Plug 'cespare/vim-toml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'plasticboy/vim-markdown' " syntax

Plug 'mileszs/ack.vim' "Ack search
Plug 'scrooloose/nerdtree'

Plug 'terryma/vim-expand-region' " + / - in visual mode
Plug 'terryma/vim-multiple-cursors' " C-n for multiple
Plug 'Chiel92/vim-autoformat' " Eh

Plug 'sjl/gundo.vim' "Under used
Plug 'tpope/vim-fugitive' "Gblame etc.

" javascript
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript' 
Plug 'maksimr/vim-jsbeautify'

" nim
Plug 'zah/nim.vim'

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()


" ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pylint'],
\   'nim': ['nimcheck'],
\}
let g:ale_python_pylint_options= '--rcfile ~/pylintrc'

let g:ale_fixers = {
\   'javascript': ['eslint']
\}

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

" go
let g:go_version_warning = 0

" nim
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i


" turn on airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

" html 2 space
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab

" javascript / es6
au BufRead,BufNewFile *.es6 set ft=javascript
au BufRead,BufNewFile *.sbt set ft=scala

set tabstop=2
set shiftwidth=2
