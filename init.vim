" Install vim-plug automatically
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
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

Plug 'cespare/vim-toml'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

" General configuration options
set showmode
set hidden
"
" Ale setup
let g:ale_linters = {
            \'rust': ['cargo', 'rustfmt'],
            \'python': ['flake8', 'pylint'],
            \'typescript': ['tslint', 'typecheck', 'tsserver'],
            \'typescript.tsx': ['tslint', 'typecheck', 'tsserver'],
            \'javascript': ['eslint'],
            \'javascript.jsx': ['eslint'],
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

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
    au User lsp_setup call lsp#register_server({
        \ 'name': 'javascript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'jsconfig.json'))},
        \ 'whitelist': ['javascript', 'javascript.jsx'],
        \ })
    autocmd FileType typescript,typescript.tsx,javascript,javascript.jsx setlocal omnifunc=lsp#complete
endif

" FZF setup
let g:fzf_layout = { 'window': 'botright 20split' }

" UI options
set termguicolors
colorscheme nord
let g:nord_italic=1
let g:nord_comment_brightness=5
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
set nobackup
set nowb
set undofile
set undodir=$HOME/.local/share/nvim/undo

" Indentation options
filetype plugin indent on  " smart auto indentation
set tabstop=4  " show existing tab with 4 spaces width
set softtabstop=4  " indent by 4 spaces when hitting tab
set shiftwidth=4  " when indenting with > or autoindenting, use 2 spaces width
set expandtab  " on pressing Tab, insert spaces
set wrap  " wrap lines

" Search options
set ignorecase
set smartcase

" Text rendering options
set linebreak  " wrap lines at convenient points, avoid wrapping a line in the middle of a word
set scrolloff=3  " the number of screen lines to keep above and below the cursor
set sidescrolloff=5  " the number of screen columns to keep to the left and and right of the cursor
syntax enable  " enable syntax highlighting

" Miscellaneous options
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
