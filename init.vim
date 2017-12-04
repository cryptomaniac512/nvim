call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/echodoc.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'jreybert/vimagit'

call plug#end()

let g:python_host_prog = '/home/cryptomaniac/Devel/Envs/py2_neovim_host/bin/python'
let g:python3_host_prog = '/home/cryptomaniac/Devel/Envs/py3_neovim_host/bin/python'

set hidden

augroup nord
    autocmd ColorScheme nord highlight MatchParen ctermbg=0 ctermfg=4
augroup END
let g:nord_comment_brightness = 10
colorscheme nord

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(
  \   '',
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

let g:ale_sign_column_always = 1

" Exit to normal mode from terminal
tnoremap <Esc> <C-\><C-n>

" use system clipboard
set clipboard=unnamed

filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
" select completion variant by pressing Enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set number
set relativenumber

" Allow per-project nvimrc files
set exrc
