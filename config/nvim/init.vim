
set nocompatible

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

Plug('fatih/vim-go')
Plug('rust-lang/rust.vim')
Plug('cespare/vim-toml')

Plug('ntpeters/vim-better-whitespace')

call plug#end()

syntax enable
set background=light

set nobackup
set nowritebackup
set noswapfile
set hidden
set signcolumn=yes

set shiftwidth=4
set expandtab

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"rust
let g:rustfmt_autosave = 1

" Use jk for escape in insert mode to get around esc being on the Mac
" TouchBar instead of a real key.
inoremap jk <esc>

filetype plugin indent on
