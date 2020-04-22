
set nocompatible

call plug#begin()

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug('fatih/vim-go')
Plug('rust-lang/rust.vim')
Plug('cespare/vim-toml')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug('ntpeters/vim-better-whitespace')

call plug#end()

syntax enable
set background=light

set nobackup
set nowritebackup
set noswapfile

set number
set relativenumber

set shiftwidth=4
set expandtab

"rust
let g:rustfmt_autosave = 1

" Use jk for escape in insert mode to get around esc being on the Mac
" TouchBar instead of a real key.
inoremap jk <esc>

filetype plugin indent on
