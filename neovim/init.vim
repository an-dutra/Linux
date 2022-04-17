call plug#begin()
  " A fuzzy file finder
  Plug 'kien/ctrlp.vim'
  " Comment/Uncomment tool
  Plug 'scrooloose/nerdcommenter'
  " Switch to the begining and the end of a block by pressing %
  Plug 'tmhedberg/matchit'
  " A Tree-like side bar for better navigation
  Plug 'scrooloose/nerdtree'
  " A cool status bar
  Plug 'vim-airline/vim-airline'
  " Airline themes
  Plug 'vim-airline/vim-airline-themes'
  " Nord
  Plug 'arcticicestudio/nord-vim'
  " Better syntax-highlighting for filetypes in vim
  Plug 'sheerun/vim-polyglot'
  " Intellisense engine
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Git integration
  Plug 'tpope/vim-fugitive'
  " Auto-close braces and scopes
  Plug 'jiangmiao/auto-pairs'

" Initialize plugin system
call plug#end()

" Spaces & Tabs {{{
  set tabstop=2       " number of visual spaces per TAB
  set softtabstop=2   " number of spaces in tab when editing
  set shiftwidth=2    " number of spaces to use for autoindent
  set expandtab       " tabs are space
  set autoindent
  set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs

" UI Config {{{
  set hidden
  set number                   " show line number
  set showcmd                  " show command in bottom bar
  set wildmenu                 " visual autocomplete for command menu
  set showmatch                " highlight matching brace
  set laststatus=2             " window will always have a status line
  set nobackup
  set noswapfile
" }}} UI Config

" Search {{{
  set incsearch       " search as characters are entered
  set hlsearch        " highlight matche
  set ignorecase      " ignore case when searching
  set smartcase       " ignore case if search pattern is lower case
                    " case-sensitive otherwise

  " set Ag as the grep command
  if executable('ag')
      " Note we extract the column as well as the file and line number
      set grepprg=ag\ --nogroup\ --nocolor\ --column
      set grepformat=%f:%l:%c%m
  endif
" }}} Search

" CocShortcuts {{{
  " Code action on <leader>a
  vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
  nmap <leader>a <Plug>(coc-codeaction-selected)<CR>

  " Format action on <leader>f
  vmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)
  " Goto definition
  nmap <silent> gd <Plug>(coc-definition)
  " Open definition in a split window
  nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L
" }}} CocShortcuts 

" NerdTreeConfig {{{
  map <C-n> :NERDTreeToggle<CR> 
  let NERDTreeShowHidden=1 " Show hidden files in NerdTree buffer.
  " <C-n> == Ctrl+n
" }}} NerdTreeConfig

" WindowSplit {{{
  " Split windows
  map <C-j> <C-W>j
  map <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l
" }}} WindowSplit

" ThemeOptions {{{
  filetype plugin indent on
  syntax on
  colorscheme nord
" }}} ThemeOptions
