call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
\ }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }


call plug#end()

set background=dark
colorscheme gruvbox
let g:CommandTCancelMap = ['<ESC>']

set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set number

map <C-b> :NERDTreeToggle<CR> 
map <C-g> :NERDTreeFind<CR>
map <C-p> :CommandT .<CR>
let NERDTreeShowHidden=1 

let g:airline_theme='wombat'

