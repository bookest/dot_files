
set nocompatible

call plug#begin()

Plug 'wikitopian/hardmode'

Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline',
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}

Plug 'sheerun/vim-polyglot'

Plug 'ntpeters/vim-better-whitespace'

Plug 'iCyMind/NeoSolarized'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

syntax enable

if trim(system('defaults read -g AppleInterfaceStyle')) == 'Dark'
    set background=dark
else
    set background=light
endif

set termguicolors
colorscheme NeoSolarized

set nobackup
set nowritebackup
set noswapfile
set hidden
set signcolumn=yes
set updatetime=500
set scrolloff=5
set relativenumber
set autoindent
set smartindent

set shiftwidth=4
set expandtab

set spelllang=en_us
set spell

set undofile
set undodir=~/.vim/undodir

let mapleader = " "

" C-c doesn't play nice with CoC.
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <C-\><C-n>

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

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"javascript
let g:javascript_plugin_jsdoc = 1

"rust
let g:rustfmt_autosave = 1

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

command! -bang -nargs=* SearchNotes
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': '~/vimwiki'}), <bang>0)

command! -bang -nargs=* EditNote call fzf#vim#files('~/vimwiki', <bang>0)

command! -bang -nargs=0 NewNote
            \ call vimwiki#base#edit_file(":e", strftime('~/vimwiki/%F-%T.md'), "")

autocmd BufNewFile ~/vimwiki/*.md :silent 0r ~/vimwiki/template.md | normal! j$

" disable C-c k triggering Omnicomplete in sql files
let g:omni_sql_no_default_maps = 1

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }
let fc = g:firenvim_config['localSettings']
let fc['https?://[^.]*\.google\.com'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://google\.com'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://[^.]*\.sumologic\.com'] = { 'takeover': 'never', 'priority': 1 }

autocmd BufEnter github.com_*.txt set filetype=markdown
autocmd BufEnter app.mode.com_*.txt set filetype=sql

filetype plugin indent on
