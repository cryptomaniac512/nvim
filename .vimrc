call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

call plug#end()

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

noremap <leader>c :Commentary<CR>


" use system clipboard
set clipboard=unnamed

filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview
" select completion variant by pressing Enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set foldmethod=indent
" set foldlevel=1

set number
set relativenumber

" Allow per-project nvimrc files
set exrc
