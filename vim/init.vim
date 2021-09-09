""""""""""""""""""""""""""
" (c) 2021 Bryce Thuilot "
""""""""""""""""""""""""""

""" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Styling
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'

" Utilies
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'


" Syntax & Langauge Support
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rust-lang/rust.vim'

call plug#end()

""" Styling 

" Airline
let g:airline_theme='wombat'
" Colorscheme
set background=dark
colorscheme gruvbox


""" Variables

" Set tabs to 2 spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab smartindent
" Show line number
set number
" Let NERDTree show hidden files
let NERDTreeShowHidden=1 
" Disable folding
set nofoldenable


""" Map keys

map <C-t> :NERDTreeToggle<CR> 
map <C-n> :NERDTreeFind<CR>
map <C-f> :Files<CR>
map <C-r> :Rg<CR>


