"Execute pathogen
execute pathogen#infect()

"Enable syntax highlighting based on file names
filetype plugin indent on
syntax on
colorscheme challenger_deep

"Add a colored column to the right side
set colorcolumn=90

"Add line numbering
set number

"Keep more info in memory
set hidden
set history=100

"Improve indenting
filetype indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

"Better search
set hlsearch

"Make backspace work like most other programs
set backspace=2
set backspace=indent,eol,start

"Command line completion
set wildmenu
set wildmode=longest:list,full

"Show matching parenthesis
set showmatch

"Leader key
let mapleader=" "

"Cancel a search with the Escape key
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

"Re-open previously opened file
nnoremap <Leader><Leader> :e#<CR>

"Make lightline statusline visible
set laststatus=2

"NERDTree settings
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
nmap <Leader>j :NERDTreeFind<CR>
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']

"Command-T settings
set wildignore+=*.log,*.sql,*.cache
noremap <Leader>r :commandTFlush<CR>

"Enable mouse support
set mouse=a

"Ignore case when searching
set ignorecase

"Disable swap
set nobackup
set nowb
set noswapfile
