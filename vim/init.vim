" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Pandoc support plugin
Plug 'vim-pandoc/vim-pandoc'
" Pandoc syntax highlighting
Plug 'vim-pandoc/vim-pandoc-syntax'
" Oceanic next colorscheme
Plug 'mhartington/oceanic-next'
" Airline and Airline themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Nerd tree
Plug 'scrooloose/nerdtree'

call plug#end()

:set number

:set tabstop=4
:set shiftwidth=4
:set expandtab

map <C-n> :NERDTreeToggle<CR>

:map <C-L> :! pandoc -o pdf.pdf -H header.tex % <CR>

colorscheme OceanicNext
