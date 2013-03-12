set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
" Line numbers
set number

" Ignore case
set ignorecase

" Incremental searches, with highlighting.
set incsearch
set hlsearch

" When I close the tab, remove the buffer.
set nohidden

" Highlight the whole line.
set cul

" Turn off annoying error bells.
set noerrorbells
set novisualbell
set t_vb=

" Use a statusline.
set laststatus=2

" Set the font.
set gfn=Monospace\ 11

" Set auto-change-directory.
set autochdir

" Don't use backups.
set backup
set backupdir=/tmp
set backupskip=/tmp/*
set directory=/tmp
set writebackup
set nocp

" Set the current working directory.
cd ~/Projects/

" Set the color scheme.
colorscheme default

let g:indent_guides_enable_on_vim_startup=0
set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
"set matchpairs+=<:>                " match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
set list
"set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
"set listchars=tab:>\ ,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
set listchars=tab:\ \ ,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

" With the following setting, Vim will search for the file named 'tags', starting
" with the directory of the current file and then going to the parent directory
" and then recursively to the directory one level above, till it either locates
" the 'tags' file or reaches the root directory.
set tags=./tags;

