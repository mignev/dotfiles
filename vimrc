call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"Don't be backwards compatible with vi
set nocompatible

" Briefly jump to matching parenthesis/bracket
set showmatch

set nowrap

" Use backups (to prevent, y'know, wiping out C code with archives...)
"set backup

set t_Co=256

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

map <C-Left> :tabprevious<CR>
map <C-Right> :tabnext<CR>

"For Tmux
map <Esc>[D :tabprev<CR> 
map <Esc>[C :tabnext<CR>

"set mouse=a

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

nnoremap <C-f><C-f> :FufFile<CR>

map <F2> :NERDTree<CR>
map <F3> :IndentGuidesToggle<CR>
map <F4> :TlistToggle<CR>

nnoremap <F8> :!/opt/local/bin/ctags -R --python-kinds=-i *.py<CR>

"If you'd like to open tag list on right,
"let Tlist_Use_Right_Window = 1

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

autocmd FileType php noremap <C-M> :w!<CR>:!clear<CR>:!php %<CR>
autocmd FileType php noremap <C-L> :w!<CR>:!clear<CR>:!php -l %<CR>

" Color schemas
" colorscheme automation
" colorscheme bclear
" colorscheme graywh
" colorscheme guepardo
" colorscheme fokus
" colorscheme eclipse
" colorscheme blackboard
"
colorscheme wombat256

let g:indent_guides_auto_colors = 1 
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

set ts=4 sw=4 et
let g:indent_guides_start_level=2 
let g:indent_guides_guide_size=1

" Backups
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup

"set ofu=syntaxcomplete#Complete
au BufNewFile,BufRead *.module set filetype=php
au BufNewFile,BufRead *.test set filetype=php
au BufNewFile,BufRead *.install set filetype=php
au BufNewFile,BufRead *.inc set filetype=php


autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType inc set omnifunc=phpcomplete#CompletePHP
" Enable enhanced command line completion.
set wildmenu wildmode=list:full
 
"  " Ignore these filenames during enhanced command line completion.
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif " binary images
set wildignore+=*.luac " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files

autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType python set
set tags+=$HOME/.vim/tags/python.ctags
inoremap <C-space> <C-x><C-o>

" You might also find this useful
" " PHP Generated Code Highlights (HTML & SQL)                                              
let php_sql_query=1
let php_htmlInStrings=1

" MacVim Settings
if has("gui_running")
    set guifont=Monaco:h13
    colorscheme blackboard
endif
