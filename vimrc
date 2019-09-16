if empty(glob('~/.local/share/nvim/site/autoload'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" GENERAL VIM PLUGINS
Plug '/usr/local/opt/fzf'
Plug 'Xuyuanp/nerdtree-git-plugin' " Shows git status for files in NERDTree
Plug 'airblade/vim-gitgutter' " Shows git status for lines in a file
Plug 'airblade/vim-rooter' " Finds the project root for NERDTree/fzf
Plug 'brooth/far.vim' " Multi-file search/replace
Plug 'bronson/vim-crosshairs'
Plug 'ciaranm/detectindent'
Plug 'dracula/vim', { 'as': 'dracula' } " Color scheme
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mhinz/vim-signify' " Faster than gitgutter
Plug 'mhinz/vim-startify' " Pretty start screen
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'} " Language server support
Plug 'ryanoasis/vim-devicons' " Pretty icons for filetypes
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'sickill/vim-pasta' "Pasting in Vim with indentation adjusted
Plug 'terryma/vim-multiple-cursors'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' " I mostly use this for :Gblame
Plug 'tpope/vim-surround'
Plug 'wincent/terminus' " Better mouse support, cursor changes by mode
Plug 'vim-airline/vim-airline'

" CSS PLUGINS
Plug 'ap/vim-css-color'

" HTML PLUGINS
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

" PHP PLUGINS
Plug 'stephpy/vim-php-cs-fixer'

call plug#end()

" GENERAL CONFIG
" ==============
set backspace=indent,eol,start
set cindent
set clipboard=unnamed
set confirm " Ask if you'd like to save the file before quitting
set copyindent
set encoding=utf-8
set gdefault " When searching/replacing, always replace all occurrences on a line
set hidden " This allows buffers to be hidden if you've modified a buffer.
set history=1000
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set nocompatible
set nohlsearch " Don't highlight all search results
set number
set regexpengine=1
set scrolloff=5
set shell=/usr/local/bin/zsh
set smartcase
set sw=2
set t_Co=256
set undolevels=1000
set visualbell
set wildignore=*.swp,*.pyc,*.class*.io,*~
set wildmenu
set wildmode=longest,list,full

map <Space> <Leader>
nnoremap <F1> <ESC>
inoremap <F1> <ESC>

color dracula
filetype plugin indent on
syntax enable

" BUFFERS
map <Leader>t :enew<CR>
map <Leader>w :bd<CR>
map <Leader>h :bprevious<CR>
map <Leader>l :bnext<CR>
map <Leader><Left> :bprevious<CR>
map <Leader><Right> :bnext<CR>

" CODE FORMATTING
set autoindent
set smartindent
set expandtab
set ts=2
set sts=2

" CUSTOM COMMANDS
command! Config :e ~/.dotfiles/vimrc

" AIRLINE CONFIG
let g:airline#extensions#tabline#enabled = 1
" Use pretty symbols for Airline
let g:airline_powerline_fonts = 1
" Make the tabs show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" COC CONFIG
" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for snippet expansion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

let g:coc_snippet_next = '<tab>'

" CROSSHAIR CONFIG
set cursorline   " enable the horizontal line
set cursorcolumn " enable the vertical line

" FZF CONFIG
let $FZF_DEFAULT_COMMAND='rg --hidden --files -g "!.git" --ignore-file ~/.gitignore'
let g:far#source='rg'

nnoremap <silent> <C-p> :call fzf#vim#files('', fzf#vim#with_preview('right')) <CR>
map <Leader>f :Rg <CR>

" Don't search filename when using :Rg
command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
  \   1)

" NERDTREE CONFIG
let NERDTreeShowHidden=1
map <Leader>b :NERDTreeToggle<CR>
map <Leader>r :NERDTreeFind<CR>

" PHP CS FIXER CONFIG
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

" RAINBOW PARENTHESES CONFIG
" Always enable:
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" VIM WORKSPACE CONFIG
nnoremap <leader>s :ToggleWorkspace<CR>
let g:workspace_session_directory = $HOME . '/.config/nvim/sessions/'
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
