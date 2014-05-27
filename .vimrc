filetype on
filetype plugin on
filetype plugin indent on

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set t_Co=256
syntax on
colorscheme Tomorrow-Night-Eighties 

set expandtab
set textwidth=79
set tabstop=8
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

set foldmethod=indent
set foldlevel=99

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <leader>n :NERDTreeToggle<CR>
execute pathogen#infect()
