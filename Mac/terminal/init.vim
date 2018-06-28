" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes
Plug 'vim-pandoc/vim-pandoc'

Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

:set number

:set tabstop=4
:set shiftwidth=4
:set expandtab

:map <C-L> :! pandoc -o pdf.pdf -H header.tex % <CR>

colorscheme OceanicNext
