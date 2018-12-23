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

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'cespare/vim-toml'

Plug 'leafgarland/typescript-vim'
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
        \ 'whitelist': ['typescript', 'typescript.jsx'],
        \ })
    au User lsp_setup call lsp#register_server({
        \ 'name': 'javascript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'jsconfig.json'))},
        \ 'whitelist': ['javascript', 'javascript.jsx'],
        \ })
    autocmd FileType typescript,typescript.jsx,javascript,javascript.jsx setlocal omnifunc=lsp#complete
endif

" Auto-pairs setup
let g:AutoPairsShortcutBackInsert = ''

" FZF setup
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

nnoremap <silent> ,/ :nohlsearch<cr>

nnoremap <c-b> <c-^>
inoremap <c-b> <esc><c-^>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

let mapleader = "\'"
nnoremap <leader>r :setlocal relativenumber!<cr>

nnoremap <leader>s :Rg<cr>
nnoremap <leader>S viwy:Rg<cr><c-w>""
nnoremap <leader>f :Files<cr>
nnoremap <leader>F viwy:Files<cr><c-w>""
nnoremap <leader>b :Buffers<cr>

inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-n> <down>
inoremap <c-p> <up>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <m-b> <c-left>
inoremap <m-f> <c-right>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <m-b> <c-left>
cnoremap <m-f> <c-right>


autocmd BufRead,BufNewFile *.tsx setlocal filetype=typescript.jsx
autocmd BufRead,BufNewFile *.pcss setlocal filetype=scss
