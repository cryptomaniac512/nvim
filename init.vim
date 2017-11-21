call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/echodoc.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()

let g:python_host_prog = '/home/cryptomaniac/Devel/Envs/py2_neovim_host/bin/python'
let g:python3_host_prog = '/home/cryptomaniac/Devel/Envs/py3_neovim_host/bin/python'

set hidden

augroup nord-overrides
  autocmd!
  autocmd ColorScheme nord highlight MatchParen ctermbg=4 ctermfg=0 guibg=#81A1C1 guifg=#2E3440
augroup END
let g:nord_comment_brightness = 10
colorscheme nord

" Exit to normal mode from terminal
tnoremap <Esc> <C-\><C-n>

" Allow per-project nvimrc files
set exrc
