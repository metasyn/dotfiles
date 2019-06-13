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
Plug 'ctrlpvim/ctrlp.vim'

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

Plug 'lingceng/z.vim'

" javascript
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript' 
Plug 'maksimr/vim-jsbeautify'

" nim
Plug 'zah/nim.vim'

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" rust
Plug 'rust-lang/rust'
Plug 'racer-rust/vim-racer'


call plug#end()

" rust racer
let g:racer_cmd = "~/.cargo/bin/racer"

" CtrlP
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8', 'mypy'],
\   'nim': ['nimcheck'],
\   'go': ['golangci-lint'],
\   'rust': ['rls', 'cargo'],
\}

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['black'],
\   'go': ['golangci-lint'],
\   'rust': ['rustfmt'],
\}
let g:ale_python_flake8_use_global = 1
let g:ale_python_flake8_options = "--config=/Users/aljohnson/go/src/cd.splunkdev.com/ML/ssc-ml/python/common/setup.cfg"

let g:ale_python_mypy_use_global = 1
let g:ale_python_mypy_options = "--config-file=/Users/aljohnson/go/src/cd.splunkdev.com/ML/ssc-ml/python/common/setup.cfg"

highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '⚠️ '

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
