" Author: Jonathan Fisher
let g:vimrc_author='Jonathan Fisher'

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
" Line numbers
set number

" Load pathogen
" execute pathogen#infect()

" Set the color scheme.
colorscheme desert

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

" Map the space bar to toggling fold level
nnoremap <Space> za

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
set noundofile

" Set auto-change-directory.
" set vim to chdir for each file
if exists('+autochdir')
    set autochdir
    autocmd VimEnter * set autochdir
else
    autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

" Automatically reload a file that's changed on disk.
set autoread

let g:indent_guides_enable_on_vim_startup=0
set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set noexpandtab                 " Use tabs, not spaces
set shiftwidth=8                " use indents of 8 spaces
set tabstop=8                   " an indentation every eight columns
set softtabstop=8               " let backspace delete indent
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
"noremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Local replacing of variable names
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
" Global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

if has("unix")
    let s:uname = substitute(system("uname -s"), "\n", "", "")
    if s:uname == "Darwin"
        map yy :w !pbcopy<CR><CR>
    endif
endif

set backup
set backupdir=/tmp
set backupskip=/tmp
set directory=/tmp
set writebackup

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backup files, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
