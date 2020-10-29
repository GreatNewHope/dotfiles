""" PLUGINS, using Plugged package manager
" Auto install Plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin declaration begin
call plug#begin('~/.vim/plugged')

" Vim Conquer of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim Surround
Plug 'tpope/vim-surround'

" Vim Commentary
Plug 'tpope/vim-commentary'

" Additional matching on pairs, using %
Plug 'vim-scripts/matchit.zip'

" Autoclose paranthesis and other structs
Plug 'tpope/vim-endwise'

" Snipe two chars
Plug 'justinmk/vim-sneak'

" Better sentence detection
Plug 'reedes/vim-textobj-sentence'

" Colortheme
Plug 'joshdick/onedark.vim'  

" Powerline (Airline)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" More complete . functionality
Plug 'tpope/vim-repeat'

" This package provides gl and gL align operators: 
" gl MOTION CHAR and right-align gL MOTION CHAR.
Plug 'tommcdo/vim-lion'

" Selected text in visual mode with * and # operators
Plug 'nelstrom/vim-visual-star-search'

" FZF integrationa (requires fzf installed)
Plug 'junegunn/fzf.vim'

" Uncomment if you want fzf to be installed by Plugged 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Preview substitutions (:OverCommandLine)
Plug 'osyo-manga/vim-over'

" Rainbow colored delimeters
Plug 'luochen1990/rainbow'

" Wrapper for common unix operations
Plug 'tpope/vim-eunuch'

" Adds :Gsearch and :wall command for in proyect editing
Plug 'skwp/greplace.vim'

" Git diff within the buffer
Plug 'airblade/vim-gitgutter'

"" Initialize plugin system
call plug#end()

""" BASIC DEFAULTS
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace wrap around lines.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" turn hybrid-relative line numbers on
set nu rnu

" Encoding
set encoding=utf-8

" Automatically wrap text that extends beyond the screen length.
set wrap

" Speed up scrolling in Vim
set ttyfast

" Enable incrsearch
set is

" AutoComplete commands
set wmnu
set wim=longest,list,full

" Squeeze extra spaces (evil-lion)
let b:lion_squeeze_spaces=1

"" tabspaces (For all filetypes, unless specified)
" The width of a TAB is set to 4.
set tabstop=4
" Indents will have a width of 4.
set shiftwidth=4
" Sets the number of columns for a TAB.
set softtabstop=4
" Expand TABs to spaces.
set expandtab

" Use ag for Gsearch 
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" augment the default foldtext() with an indicator of whether the folded lines have been changed.
set foldtext=gitgutter#fold#foldtext()

""" Key Bindings
" Space as leader key
let mapleader=" "

" CTRL + l to unhighlight text
nnoremap <C-l> :nohl<CR><C-l>

" Look for a file
nnoremap <silent> <Leader>f :Files<CR>

" replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
" replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

"" vim-gitgutter
" Remove default keybindings
let g:gitgutter_map_keys = 0

" Jump to hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Hunk text objects
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" g-based hunk staging/unstaging
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

" g-based hunk previews
nmap ghp <Plug>(GitGutterPreviewHunk)

""" Presentation
" 24-bit color
set termguicolors

" Colorscheme
colorscheme onedark

" Airline Theme
let g:airline_theme='onedark'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled=1
let g:airline_skip_empty_sections=1

" Highlight searches
set hlsearch

" Activate rainbow delimeters
let g:rainbow_active=1 

" Git Gutter Higher refresh rate
set updatetime=250

""" gvim only
if has('gui_running')
    " menu bar
    set guioptions-=m
    " toolbar
    set guioptions-=T
    " scrollbar
    set guioptions-=r
    set guioptions-=L
endif
