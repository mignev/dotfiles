" MacVim Settings
set guifont=Monaco:h12

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"Don't be backwards compatible with vi
set nocompatible

" Briefly jump to matching parenthesis/bracket
set showmatch

" Use backups (to prevent, y'know, wiping out C code with archives...)
"set backup

" Enable syntax highlighting, indenting, etc.
syntax enable

filetype on
filetype plugin on
filetype indent plugin on

helptags ~/.vim/doc

" Easily mark a single line in character-wise visual mode
"xnoremap v <esc>0v$
nnoremap vv _v$h

" Always move through visual lines:
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" Faster scrolling:
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

" Read modelines
set modeline

" Configure folding
"set foldenable
"set foldmethod=syntax

" Number lines
set number

" Use lazy redrawing (don't redraw during macros etc.)
set lz

"completion
set completeopt=menuone

" show a completion popup for commands
set wildmenu

" Use four-space tabs, and expand them
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number                 " Show gutter with line numbers.
set ruler                  " Show line, column and scroll info in status line.
set modelines=10           " Use modeline overrides.
set showcmd                " Show partially typed command sequences.
set scrolloff=5            " Minimal number of lines to always show above/below the caret.

" Custom status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
set laststatus=2           " Always show status bar.

" Highlight extended_variables as such
let perl_extended_vars=1

" Allow viewing of man pages using the :Man command
runtime! ftplugin/man.vim

set bg=dark

" Search settings
set hlsearch
set incsearch
set ignorecase
"set smartcase

map <F2> :NERDTree<CR>
map <F3> :IndentGuidesToggle<CR>

" Correct some spelling mistakes
ia teh the
ia htis this
ia tihs this
ia sefl self
ia slef self
ia eariler earlier
ia funciton function
ia funtion function
ia fucntion function
ia retunr return
ia reutrn return
ia foreahc foreach
ia !+ !=
ca eariler earlier
ca !+ !=
ca ~? ~/

" Much easier to type commands this way
no ; :

let g:snips_author = "Marian Ignev"

autocmd BufNewFile *.c* so ~/c_header.tpl
autocmd BufNewFile *.c* exe "1," . 5 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd BufNewFile *.c* exe "1," . 5 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.c exe "1," . 5 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd BufNewFile *.c* exe "1," . 5 . "g/Created By :.*/s//Created By : " .g:snips_author

" Color schemas
" colorscheme automation
" colorscheme bclear
" colorscheme graywh
" colorscheme guepardo
" colorscheme fokus
" colorscheme eclipse
"
colorscheme blackboard

let g:indent_guides_auto_colors = 1 
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

set ts=4 sw=4 et
let g:indent_guides_start_level=2 
let g:indent_guides_guide_size=1

" Backups
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup
