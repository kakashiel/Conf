" =========================================================================
" General
" =========================================================================

set nocompatible
filetype plugin indent on
syntax on
set background=dark
colorscheme distinguished    " thème de coloration
colorscheme vitamins    " thème de coloration
set t_Co=256            " Coloration syntaxique
set mouse=a             " permet l'utilisation de la souris
set bs=2                " redefinition du backspace
set lbr                 " laisse les mots entier
set ff=unix             " fin de ligne format unix
set title               " affiche le titre dans la barre de titre du term
set spelllang=fr        " correction orthographique
set number


" =========================================================================
" Saving and Encoding
" =========================================================================

set encoding=utf-8
set fileencoding=utf-8
" Automatically removing all trailing whitespace
" TODO: FIX IT
autocmd BufWritePre <buffer> :%s/\s\+$//e


" =========================================================================
" Indentation
" =========================================================================
setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal textwidth=80
setlocal noexpandtab
setlocal cindent
setlocal cinoptions=:0,l1,t0,g0,(0

set shiftround
set smarttab
set autoindent
set smartindent
set copyindent

"set cino=(0,u0,U0,t0,g0,N-s,{s,>2s,^-s,n-s


" =========================================================================
" Wrapping
" =========================================================================

"set wrap
set textwidth=80


" =========================================================================
" Edition zone
" =========================================================================

"set relativenumber      " active la numérotation relative
set cursorline          " met en valeur la ligne du curseur
set scrolloff=3

" affiche les retour chariot, les espaces...
set list
set listchars=tab:>\ ,nbsp:.,trail:.,eol:¬

set backspace=indent,eol,start

set noerrorbells        " désactive les alertes sonores
set visualbell

set pastetoggle=<C-p>

"set foldmethod=syntax


" =========================================================================
" Search
" =========================================================================

set ignorecase          " ignore la case dans la recherche
set smartcase           " sauf si c'est une majuscule
set incsearch           " recherche incrémentale
set nohls               " ne pas mettre les termes recherché en surbrillance
set showmatch
set gdefault


" =========================================================================
" Status line and window bottom
" =========================================================================

set wildmenu
set wildmode=list:longest:full
set wildignore=*.swp,*.bak,*.pyc,*.class,*.cls

set laststatus=2        " barre de statut en permanance
set ruler
set showmode
set showcmd


" =========================================================================
" Buffers and windows
" =========================================================================

set hidden
set noswapfile

" Navigation dans les buffeurs
"map <leader>t :bp<cr>
"map <leader>s :bn<cr>

set guioptions-=r       " supprime la scrollbar droite en mode gui
set guioptions-=L       " ... la gauche
set guioptions-=T       " ... la toolbar

let mapleader = ","
map <Leader>k :bp<CR>
map <Leader>l :bn<CR>
map <Leader>i gg=G<CR>
map <Leader>$ :tabnew<CR>
map <Leader>o gT<CR>
map <Leader>p gt<CR>


" =========================================================================
" History, Undo and Backup
" =========================================================================

set history=999
set undolevels=1000

"silent !mkdir -p ~/.vim/tmp/{backup,tmp}

"set backup
"set backupdir=~/.vim/tmp/backup
"set directory=~/.vim/tmp/tmp

"set undofile
"set undodir=~/.vim/tmp/undo
"silent !mkdir -p ~/.vim/tmp/undo
" =========================================================================
" Plugins
" =========================================================================

call pathogen#infect()
"imap <c-space> <c-x><c-o>
highlight Pmenu ctermbg=238 gui=bold


" =========================================================================
" Java
" =========================================================================

au FileType java set et sts=4 sw=4
" Nécessite le plugin javacomplete
setlocal omnifunc=javacomplete#Complete
setlocal completefunc=javacomplete#CompleteParamsInfo
au bufNewFile *.java 0r ~/.vim/template/java.java   " Template java


" =========================================================================
" Ruby and Rails
" =========================================================================

autocmd FileType ruby,eruby set et sts=2 sw=2
" vim must be compiled with +ruby option
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1


" =========================================================================
" PHP
" =========================================================================

let php_htmlInStrings=1 " Permet de colorer du html dans du php
"au bufNewFile *.php 0r /usr/share/vim/vimfiles/template/php.php " Templates


" =========================================================================
" Completion
" =========================================================================

" Complete options (disable preview scratch window)
set completeopt=longest,menuone
" Limit popup menu height
set pumheight=15
" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"
" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 0
" Show clang errors in the quickfix window
let g:clang_complete_copen = 1


" =========================================================================
" Tagbar
" =========================================================================

nmap <F8> :TagbarToggle<CR>


" =========================================================================
" NeerdTree
" =========================================================================

map <Leader>n :NERDTreeToggle<CR>
nmap <F7> :NERDTreeToggle<CR>


" =========================================================================
" Coding Style
" =========================================================================

highlight OverLength ctermbg=grey ctermfg=white guibg=#592929
match OverLength /\%80v.\+/


" =========================================================================
" Pyclew
" =========================================================================

":map <C-I> :exe "Pyclew " <CR>
":map <C-X> :exe "Cprint *" . expand("<cword>") <CR>
":map <C-P> :exe "Cprint " . expand("<cword>") <CR>
":map <C-E> :exe "Cstep" <CR>
":map <C-N> :exe "Cnext" <CR>
":map <C-C> :exe "Ccontinue" <CR>
":map <C-L> :exe "Cstart" <CR>
":map <C-H> :exe "Cup" <CR>
":map <C-B> :exe "Cdown" <CR>


" =========================================================================
" C++11
" =========================================================================

"let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_check_header = 1


" =========================================================================
" Node.js
" =========================================================================

au BufNewFile,BufRead *.ejs set filetype=html
