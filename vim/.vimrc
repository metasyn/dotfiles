set nocompatible
set encoding=utf-8
filetype plugin on

set undofile
set undodir=$HOME/.vimundo

" if you don't have plug, you need to run
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" pretty status line
Plug 'vim-airline/vim-airline' " basic
Plug 'vim-airline/vim-airline-themes' " pretty

Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
Plug 'dag/vim-fish'

" javascript
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'maksimr/vim-jsbeautify'

" nim
Plug 'zah/nim.vim'

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" hack
Plug 'hhvm/vim-hack'

" java/scala
Plug 'artur-shaik/vim-javacomplete2'
Plug 'derekwyatt/vim-scala'

Plug 'edma2/vim-pants'
Plug 'tpope/vim-dispatch'

" arudino
Plug 'stevearc/vim-arduino'

" Python
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

" various
Plug 'solarnz/thrift.vim'

call plug#end()

function! Slackfmt(buffer) abort
    let l:executable ='/Users/xjohnson/src/webapp/bin/hackfmt'
    return {'command': ale#Escape(l:executable) . ' %t -i %s', 'read_temporary_file': 1,}
endfunction

"java/scala
let g:java_highlight_functions = 1
let g:java_highlight_all = 1
highlight link javaScopeDecl Statement
highlight link javaType Type
highlight link javaDocTags PreProcc

" scala
au BufRead,BufNewFile *.sbt set filetype=scala

let g:ale_linters = {
\   'javascript':   ['eslint'],
\   'python':       ['flake8'],
\   'nim':          ['nimlsp', 'nimcheck'],
\   'go':           ['golangci-lint'],
\   'rust':         ['rls', 'cargo'],
\   'hack':         ['hack', 'hhast'],
\   'java':         ['checkstyle', 'javac', 'javalsp'],
\   'scala':        ['scalac', 'scalastyle', 'sbtserver', 'fsc'],
\}

let g:ale_fixers = {
\   'nim':          ['nimpretty'],
\   'javascript':   ['eslint'],
\   'python':       ['yapf'],
\   'go':           ['golangci-lint'],
\   'rust':         ['rustfmt'],
\   'java':         ['google_java_format'],
\   'scala':        ['scalafmt'],
\   'hack':         ['Slackfmt'],
\   '*':            ['remove_trailing_lines', 'trim_whitespace'],
\}

" Async Linting Engine
highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1
let g:ale_fix_on_save = 1

let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '⚠️ '
let g:ale_sign_info = '🐟 '

" Conqueror of Completion
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" nerd tree
nnoremap <Leader>f :NERDTreeToggle<Enter>

" fzf
if executable('fzf')
  set rtp+=/usr/local/opt/fzf
endif

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
set backspace=2
set nu
set ruler
set smartindent
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set foldmethod=indent
set foldlevel=99

" because who don't love copy pasta, bay bee !
if !has('nvim')
  set clipboard=unnamedplus,unnamed,autoselect
endif

" nvim/normal vim compatible
set clipboard+=unnamedplus


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
