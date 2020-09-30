set nocompatible              " be iMproved, required
filetype off                  " required

" Set leader key
let mapleader = ","

call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/vim-plug'
Plug 'psf/black', { 'for' : 'python' }
Plug 'pedrohdz/vim-yaml-folds', { 'for' : 'yaml' }
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc-git'
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'tpope/vim-unimpaired'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'masukomi/vim-markdown-folding', { 'for' : 'markdown' }
Plug 'sjl/gundo.vim'

call plug#end()


" Ale settings
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
" let g:ale_sign_error = '●'
" let g:ale_sign_warning = '.'
let g:ale_lint_on_text_changed = 'never'

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" Handle indenting things
set expandtab       "Use softtabstop spaces instead of tab characters for indentation
set shiftwidth=4    "Indent by 4 spaces when using >>, <<, == etc.
set softtabstop=4   "Indent by 4 spaces when pressing <TAB>

set autoindent      "Keep indentation from previous line
set smartindent     "Automatically inserts indentation in some cases
set cindent         "Like smartindent, but stricter and more customisable

if has ("autocmd")
    " File type detection. Indent based on filetype. Recommended.
    filetype plugin indent on
endif

" Useful settings
syntax on " Turn on syntax highlighing

" -- Display
set title                 " Update the title of your window or your terminal
" set number                " Display line numbers
" set ruler                 " Display cursor position
" set wrap                  " Wrap lines when they are too long

set scrolloff=3           " Display at least 3 lines around you cursor
                          " (for scrolling)

" set guioptions=T          " Enable the toolbar

" -- Search
set ignorecase            " Ignore case when searching
set smartcase             " If there is an uppercase in your search term
                          " search case sensitive again
set incsearch             " Highlight search results when typing
set hlsearch              " Highlight search results

" -- Beep
set visualbell            " Prevent Vim from beeping
set noerrorbells          " Prevent Vim from beeping

" Backspace behaves as expected
set backspace=indent,eol,start

" Hide buffer (file) instead of abandoning when switching
" to another buffer
set hidden

" Folding settings
set foldlevelstart=20
autocmd BufWinEnter * silent! :%foldopen!

" Another way to do <esc>
" Press the j 2 times in row 
:imap jj <Esc>

" CtrlP setup
" nnoremap <Leader>b :CtrlPBuffer<CR>

" ZFZ Setup
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Setup backup, swap, etc directories
set undofile

" CTags setup
set tags=tags; " Look for tags file recursively in parent directories
" Regenerate tags when saving certain types of files
autocmd BufWritePost *.py,*.pm,*.pl,*.json,*.yml silent! !ctags -R &
