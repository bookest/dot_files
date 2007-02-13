
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nocompatible

" runtime should work, but set it up anyways
"set runtimepath="$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after"

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		" always set autoindenting on
set backup		" keep a backup file
set backupext=.bak
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set guioptions-=m	" turn off menubar
set guioptions-=r       " turn off scrollbar
set go-=T		" turn off toolbar

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" 
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")

  filetype plugin indent on

  " Map ,# to comment a line or selected block in visual mode, language
  " independent

  " lots of this crap is common to many languages, figure out how to put in a function or
  " something
  " 
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  
  "perl scripts
  autocmd FileType perl setlocal ts=2
  autocmd FileType perl setlocal shiftwidth=2
  autocmd FileType perl setlocal et
  autocmd FileType perl map <silent><buffer> h :!perldoc -f <cword><CR>
  autocmd FileType perl map <silent><buffer> ,# :s/^/#/<CR>:nohlsearch<CR>
  autocmd FileType perl map <silent><buffer> ,$ :s/^#//<CR>:nohlsearch<CR>
  autocmd FileType perl setlocal makeprg=perl\ -wc\ %
  autocmd FileType perl setlocal errorformat=%m\ at\ %f\ line\ %l%.%#,\%-G%.$#

  "shell scripts
  autocmd FileType sh setlocal ts=3
  autocmd FileType sh setlocal et
  autocmd FileType sh setlocal shiftwidth=3
  autocmd FileType sh map <silent><buffer> ,# :s/^/#/<CR>:nohlsearch<CR>
  autocmd FileType sh map <silent><buffer> ,$ :s/^#//<CR>:nohlsearch<CR>

  "html
  autocmd FileType html map <silent><buffer> ,# :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
 
  "vim scripts
  autocmd FileType vim setlocal ts=3
  autocmd FileType vim setlocal shiftwidth=3
  autocmd FileType vim setlocal et
  autocmd FileType vim map <silent><buffer> ,# :s/^/"/<CR>:nohlsearch<CR>
  autocmd FileType vim map <silent><buffer> ,$ :s/^"//<CR>:nohlsearch<CR>
  
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")
