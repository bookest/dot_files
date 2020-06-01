
set nocompatible

call plug#begin()

Plug 'wikitopian/hardmode'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline',
Plug 'vim-airline/vim-airline-themes'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

Plug 'sheerun/vim-polyglot'

Plug 'ntpeters/vim-better-whitespace'

Plug 'iCyMind/NeoSolarized'

call plug#end()

syntax enable

set background=light
set termguicolors
colorscheme NeoSolarized

set nobackup
set nowritebackup
set noswapfile
set hidden
set signcolumn=yes
set updatetime=500
set scrolloff=10
set relativenumber
set autoindent
set smartindent

set shiftwidth=4
set expandtab

set spelllang=en_us
set spell

let mapleader = " "

" Reformat paragraph
nnoremap <leader>fp gqip

nnoremap <silent> <C-p> :GFiles<cr>

"TODO: Move coc business out to a separate file?
" Use ` [g` and ` ]g` to navigate diagnostics
nmap <silent> <leader>[g <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Rename symbol
nmap <silent> <leader>rn <Plug>(coc-rename)

nnoremap <silent> <leader>k :call CocAction('doHover')<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"javascript
let g:javascript_plugin_jsdoc = 1

"rust
let g:rustfmt_autosave = 1

" Use jk for escape in insert mode to get around esc being on the Mac
" TouchBar instead of a real key.
inoremap jk <esc>
" Enable jk as escape in terminal mode as well.
tnoremap jk <C-\><C-n>

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

filetype plugin indent on
