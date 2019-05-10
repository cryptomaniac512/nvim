" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }

Plug 'w0rp/ale'
Plug 'natebosch/vim-lsc'

Plug 'jreybert/vimagit'
Plug 'mbbill/undotree'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'cespare/vim-toml'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'RRethy/vim-hexokinase'
Plug 'mattn/emmet-vim'
call plug#end()

" General configuration options
set nocompatible
set backspace=indent,eol,start  " allow backspacing over
set history=10000
set showcmd  " show incomplete commands at the bottom
set showmode
set autoread
set nohidden

" Ale setup
let g:ale_linters = {
            \'rust': ['cargo', 'rls'],
            \'python': ['flake8', 'pylint'],
            \'typescript': ['tslint', 'typecheck', 'tsserver'],
            \'typescript.tsx': ['tslint', 'typecheck', 'tsserver'],
            \'javascript': ['eslint'],
            \'javascript.jsx': ['eslint'],
            \}
let g:ale_fixers = {
            \'rust': ['rustfmt'],
            \'python': ['isort', 'yapf', 'black'],
            \'typescript': ['tslint', 'prettier'],
            \'typescript.tsx': ['tslint', 'prettier'],
            \'json': ['prettier'],
            \'html': ['prettier'],
            \}
let g:ale_echo_msg_format='%code: %%s [%linter%]'
let g:ale_sign_column_always=1
let g:ale_rust_cargo_use_clippy=1
let g:ale_rust_rls_toolchain=''

" lsc
let g:lsc_server_commands = {
      \ 'python': 'pyls',
      \ 'typescript.jsx': 'typescript-language-server --stdio',
      \ 'typescript': 'typescript-language-server --stdio',
      \ 'javascript.jsx': 'typescript-language-server --stdio',
      \ 'javascript': 'typescript-language-server --stdio',
      \ 'rust': 'rls',
      \ }
let g:lsc_auto_map = {'defaults': v:true, 'Completion': 'omnifunc'}
let g:lsc_enable_autocomplete = v:false
let g:lsc_enable_diagnostics = v:false

" Auto-pairs setup
let g:AutoPairsShortcutBackInsert = ''

" Commentary setup
nnoremap <silent> <c-\> :Commentary<cr>j
vnoremap <silent> <c-\> :Commentary<cr>j

" FZF setup
let g:fzf_layout = { 'window': 'botright 20split' }
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'],
    \ }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%', '?'),
  \   <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(
  \ <q-args>,
  \ <bang>0 ? fzf#vim#with_preview('up:60%')
  \         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)

" Vim-jsx setup
let g:jsx_ext_required=1

" vim-hexokinase
let g:Hexokinase_highlighters = ['sign_column']
let g:Hexokinase_ftAutoload = ['*']

" netrw setup
let g:netrw_localrmdir='rm -r'
let g:netrw_banner=0

" UI options
set termguicolors
colorscheme nord
let g:nord_italic=1
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
filetype plugin indent on  " smart auto indentation
set tabstop=2  " show existing tab with 2 spaces width
set softtabstop=2  " indent by 2 spaces when hitting tab
set shiftwidth=2  " when indenting with > or autoindenting, use 2 spaces width
set expandtab  " on pressing Tab, insert spaces
set wrap  " wrap lines
set autoindent
set smartindent

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
set completeopt-=preview

" Mappings
nnoremap n nzz
nnoremap N Nzz

nnoremap <silent> ,/ :nohlsearch<cr>

nnoremap <c-b> <c-^>
inoremap <c-b> <esc><c-^>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

let mapleader = "\'"
nnoremap <leader>r :setlocal relativenumber!<cr>

" project context (starts with <c-c>p)
nnoremap <c-c>ps :Rg<cr>
nnoremap <c-c>pf :Files<cr>
vmap <c-c>ps y:Rg<cr><c-r>"
vmap <c-c>pf y:Files<cr><c-r>"

" current buffer context (starts with <c-c>c or <leader>)
nnoremap <leader>f :Files %:h<cr>
nnoremap <leader>e :e %:h<cr>
nnoremap <silent> <leader>i :ALEFix<cr>

" without context (starts with <c-x> and other)
nnoremap <c-x>b :Buffers<cr>

inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-n> <down>
inoremap <c-p> <up>
inoremap <C-a> <Home>
inoremap <C-e> <End>
" like Meta-<something>
" inoremap <esc>b <c-left>
" inoremap <esc>f <c-right>
" inoremap <esc><BS> <c-w>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" like Meta-<something>
" cnoremap <esc>b <c-left>
" cnoremap <esc>f <c-right>
" cnoremap <esc><BS> <c-w>

" awkward commands fixes
tnoremap <c-r> <c-w>"
cnoremap W w


autocmd BufRead,BufNewFile *.tsx setlocal filetype=typescript.jsx
autocmd BufRead,BufNewFile *.pcss setlocal filetype=scss
