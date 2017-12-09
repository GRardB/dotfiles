if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe', {'dir': '~/.vim/plugged/YouCompleteMe', 'do': './install.py --tern-completer'}
Plug 'altercation/vim-colors-solarized'
Plug 'bronson/vim-crosshairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/tComment'
Plug 'rizzatti/dash.vim'

Plug 'slashmili/alchemist.vim'
Plug 'w0rp/ale'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:alchemist_tag_disable = 1

" clipboard
set pastetoggle=<F2>
set clipboard=unnamed

" colors
set t_Co=256
set background=dark
colorscheme solarized
let g:airline_theme='solarized'

" commands
command! ProjectFiles execute 'Files' s:find_git_root()

" crosshairs
set cursorline   " enable the horizontal line
set cursorcolumn " enable the vertical line

" elixir
let g:alchemist_tag_disable = 1

" enable all the things
filetype plugin indent on
syntax enable

" files
set autochdir
set encoding=utf-8
set wildignore=*.swp,*.pyc,*.class*.io,*~
set wildmenu
set wildmode=longest,list,full

" file types
au BufNewFile,BufRead *.js set ft=javascript.jsx
au BufNewFile,BufRead *.tsx set ft=typescript.jsx
au BufRead,BufNewFile *.md setlocal textwidth=80

" fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" functions
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

" fzf
let $FZF_DEFAULT_COMMAND='ag -g "" --hidden --ignore .git --ignore node_modules'

" history
set history=1000
set undolevels=1000

" hooks
autocmd BufWritePre * if index(['markdown'], &ft) < 0 | %s/\s\+$//e " strip trailing whitespace except in markdown
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" indentation
set autoindent
set smartindent
set backspace=indent,eol,start
set cindent
set copyindent
set expandtab
set sts=2
set sw=2
set ts=2

" markdown
let g:vim_markdown_folding_disabled = 1

" misc options
set mouse=r "come on, neovim
set nocompatible
set number
set scrolloff=5
set shell=/usr/local/bin/zsh
set laststatus=2

" postgresql
let g:sql_type_default = 'pgsql'

" search
set gdefault
set ignorecase
set incsearch
set nohlsearch
set smartcase

" shortcuts
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-p> :ProjectFiles <cr>
noremap <F1> <Esc>
inoremap <F1> <Esc>

" sounds
set visualbell
