" Author: Jonathan Fisher
let g:vimrc_author='Jonathan Fisher'

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
" Line numbers
set number

" Set the color scheme.
colorscheme default

" Use 256 colors
set t_Co=256

" Ignore case
set ignorecase

" Ignore some file extensions
if exists("g:ctrl_user_command")
	unlet g:ctrlp_user_command
endif
set wildmenu   " Turn on command line completion
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.png,*.gif,*.mp3
set wildmode=list:longest

set lazyredraw " Don't redraw while running macros

" Incremental searches, with highlighting.
set incsearch
set hlsearch

" When I close the tab, remove the buffer.
set nohidden

" Turn off annoying error bells.
set noerrorbells
set novisualbell
set t_vb=

" Set folding
set foldmethod=indent
" Map the space bar to toggling fold level
nnoremap <Space> za

" When creating a new .c file, add a header.
"autocmd bufnewfile *.c so /home/jfisher/Projects/config-files/c_header.txt
"autocmd bufnewfile *.c exe "1," . 7 . "g/File Name:.*/s//File Name: " .expand("%")
"autocmd bufnewfile *.c exe "1," . 7 . "g/Created By:.*/s//Created By: " . g:vimrc_author
"autocmd bufnewfile *.c exe "1," . 7 . "g/Creation Date:.*/s//Creation Date: " .strftime("%m-%d-%Y")
"autocmd Bufwritepre,filewritepre *.c execute "normal ma"
"autocmd Bufwritepre,filewritepre *.c exe "1," . 7 . "g/Last Modified:.*/s/Last Modified:.*/Last Modified: " . strftime("%c")
"autocmd bufwritepost,filewritepost *.c execute "normal `a"

" When creating a new header file, wrap it with ifdefs
autocmd bufnewfile *.h
	\ exe "normal i#ifndef __" . toupper(expand("%:t:r")) . "_H__\n" .
	\ "#define __" .toupper(expand("%:t:r")) . "_H__\n\n" .
	\ "#endif\n"  |
	\ execute "normal 3gg"

" Use a statusline.
set laststatus=2

" Set the font.
set gfn=Monospace\ 11

" Don't use backups.
set backup
set backupdir=/tmp
set backupskip=/tmp/*
set directory=/tmp
set writebackup
set nocp

" Set the current working directory.
cd ~/Projects/

" Set auto-change-directory.
set autochdir

let g:indent_guides_enable_on_vim_startup=0
set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set expandtab                   " Use spaces, not tabs
set shiftwidth=4                " use indents of 4 spaces
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
set list
set listchars=tab:\ \ ,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

" With the following setting, Vim will search for the file named 'tags', starting
" with the directory of the current file and then going to the parent directory
" and then recursively to the directory one level above, till it either locates
" the 'tags' file or reaches the root directory.
set tags=./tags;

" Wildmode
set wildmode=longest,list,full
set wildmenu

" Map the <F9> key to "make"
:map <f9> :make

" Set the column marker at 80 characters.
if exists("+colorcolumn")
    set colorcolumn=81
endif

if &background == "light"
	highlight ColorColumn ctermbg=lightgrey
else
	highlight ColorColumn ctermbg=black
endif

highlight Search ctermbg=darkblue ctermfg=white

" Highlight the whole line.
set cursorline
highlight CursorLine ctermbg=NONE ctermfg=NONE cterm=bold
highlight CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
noremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Local replacing of variable names
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
" Global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
