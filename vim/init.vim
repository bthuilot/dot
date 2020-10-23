call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'


call plug#end()

set background=dark
colorscheme gruvbox
let g:pandoc#syntax#conceal#use = 0

set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set number

map <C-b> :NERDTreeToggle<CR> 
map <C-g> :NERDTreeFind<CR>
map <C-p> :CommandT .<CR>
map <C-m> :!../makepdf.sh<CR>
let NERDTreeShowHidden=1 

let g:airline_theme='wombat'

