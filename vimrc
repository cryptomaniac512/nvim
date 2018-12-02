" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'w0rp/ale'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'jreybert/vimagit'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" General configuration options
set nocompatible
set backspace=indent,eol,start  " allow backspacing over
set history=10000
set showcmd  " show incomplete commands at the bottom
set showmode
set autoread
set hidden
"
" Ale setup
let g:ale_linters = {
            \'rust': ['cargo', 'rustfmt'],
            \'python': ['flake8', 'pylint'],
            \}
let g:ale_echo_msg_format='%code: %%s [%linter%]'
let g:ale_sign_column_always=1
let g:ale_rust_cargo_use_clippy=1

" LSP setup
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
        \ 'whitelist': ['rust'],
        \ })
    autocmd FileType rust setlocal omnifunc=lsp#complete
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
    autocmd FileType python setlocal omnifunc=lsp#complete
endif

" UI options
set termguicolors
colorscheme nord
let g:nord_italic=1
let g:nord_comment_brightness=5
set laststatus=2  " always display the statusbar
set ruler  " always show cursor position
set wildmenu  " display command line's tab complete options as a menu
set number  " show line numbers on the sidebar
set relativenumber
set noerrorbells
set visualbell
set mouse=a  " enable mouse for scrolling and resizing
set title  " set the window's title, reflecting the file currently being edited

" Folding
set foldenable
set foldlevelstart=10  " open most of the folds by default
set foldnestmax=10  " folds can be nested, so max value will protect from too many folds
set foldmethod=syntax  " type of folding

" Swap, backup and undo
set swapfile
set directory=$HOME/.vim/swp//
set nobackup
set nowb
set undofile
set undodir=$HOME/.vim/undo/

" Indentation options
set autoindent
filetype plugin indent on  " smart auto indentation
set tabstop=4  " show existing tab with 4 spaces width
set softtabstop=4  " indent by 4 spaces when hitting tab
set shiftwidth=4  " when indenting with > or autoindenting, use 2 spaces width
set expandtab  " on pressing Tab, insert spaces
set nowrap  " don't wrap lines

" Search options
set incsearch  " find the next match as we type the search
set hlsearch
set ignorecase
set smartcase

" Text rendering options
set encoding=utf-8
set linebreak  " wrap lines at convenient points, avoid wrapping a line in the middle of a word
set scrolloff=3  " the number of screen lines to keep above and below the cursor
set sidescrolloff=5  " the number of screen columns to keep to the left and and right of the cursor
syntax enable  " enable syntax highlighting

" Miscellaneous options
set nrformats-=octal  " interpret octal as decimal when incrementing nubers
set exrc  " enable project specific vimrc
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Mappings
nnoremap n nzz
nnoremap N Nzz

nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

vnoremap . :normal.<cr>

nnoremap <silent> ,/ :nohlsearch<cr>

nnoremap <c-b> <c-^>
inoremap <c-b> <esc><c-^>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

let mapleader = "\'"
nnoremap <leader>r :setlocal relativenumber!<cr>

" Functions
augroup toggle_relative_number
autocmd InsertEnter * :setlocal norelativenumber
autocmd InsertLeave * :setlocal relativenumber
