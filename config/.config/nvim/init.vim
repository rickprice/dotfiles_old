set nocompatible              " be iMproved, required
filetype off                  " required

let g:is_nvim = has('nvim')
let g:is_vim8 = v:version >= 800 ? 1 : 0

if !g:is_nvim && g:is_vim8
" Download and install vim-plug (cross platform), but for Vim
if empty(glob(
                \ '$HOME/' . (has('win32') ? 'vimfiles' : '.vim') . '/autoload/plug.vim'))
  execute '!curl -fLo ' .
      \ (has('win32') ? '\%USERPROFILE\%/vimfiles' : '$HOME/.vim') . 
          \ '/autoload/plug.vim --create-dirs ' .
              \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
                endif
else
if empty(glob(
                \ '$HOME/' . (has('win32') ? 'AppData/Local/nvim/site' : '.local/share/nvim/site') . '/autoload/plug.vim'))
  execute '!curl -fLo ' .
      \ (has('win32') ? '\%USERPROFILE\%/vimfiles' : '$HOME/.local/share/nvim/site') . 
          \ '/autoload/plug.vim --create-dirs ' .
              \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
                endif
endif

:colorscheme delek

" Set leader key
let mapleader = "\<Space>" 

if !g:is_nvim && g:is_vim8
call plug#begin('~/.vim/plugged')
else
call plug#begin(stdpath('data') . '/plugged')
endif

if !g:is_nvim && g:is_vim8
Plug 'psf/black', { 'for' : 'python' }
Plug 'w0rp/ale'
else
Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-plug'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'masukomi/vim-markdown-folding', { 'for' : 'markdown' }
" Plug 'sjl/gundo.vim'
Plug 'tommcdo/vim-exchange'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'Yggdroot/indentLine'
Plug 'pedrohdz/vim-yaml-folds'
" Plug 'Plug 'justinmk/vim-sneak'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

"UtilSnips engine
Plug 'SirVer/ultisnips'

" UtilSnips snippets provider
Plug 'honza/vim-snippets'

Plug 'chrisbra/csv.vim'

" Improved incremental search
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" Vim Sensible
Plug 'tpope/vim-sensible'

call plug#end()


" ZFZ Setup
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
set grepprg=rg\ --vimgrep\ --smart-case\ --follow



if g:is_nvim && !g:is_vim8
" CoC Setup
let g:coc_global_extensions = ['coc-python', 'coc-yaml', 'coc-json', 'coc-git', 'coc-docker', 'coc-actions', 'coc-markdownlint', 'coc-perl', 'coc-sh', 'coc-fzf-preview', 'coc-spell-checker' ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <leader>dia :CocDiagnostics<cr>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc-spell-checker
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

endif

" Scrolling setup
set scrolloff=3           " Display at least 3 lines around you cursor
                          " (for scrolling)
" Useful settings
syntax on " Turn on syntax highlighing

" -- Display
set title                 " Update the title of your window or your terminal
" set number                " Display line numbers
" set ruler                 " Display cursor position
" set wrap                  " Wrap lines when they are too long
:set number relativenumber

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
let g:indentLine_char = '⦙'

" Handle indenting things
set expandtab       "Use softtabstop spaces instead of tab characters for indentation
set shiftwidth=4    "Indent by 4 spaces when using >>, <<, == etc.
set softtabstop=4   "Indent by 4 spaces when pressing <TAB>

set autoindent      "Keep indentation from previous line
set smartindent     "Automatically inserts indentation in some cases
set cindent         "Like smartindent, but stricter and more customisable

" toggle show whitespace
noremap <F3> :set list!<CR>

" :w!! to save with sudo
ca w!! w !sudo -S tee >/dev/null "%"

" Insert current date or date and time in insert mode
iabbrev <silent> dst <C-R>=strftime("%Y-%m-%d")<cr>
iabbrev <silent> dstm <C-R>=strftime("%Y-%m-%d, %H:%M:%S ")<cr>

" Insert current filename
iabbrev <silent> crr <C-R>=expand('%:t:r')<cr>

" Insert result of external command
function! ExternalCommandResult()                                                                                                                         
  return system(input('Command: '))[:-2]                                                                                                                  
endfunction                                                                                                                                               
inoremap <C-R>! <C-R>=ExternalCommandResult()<cr>                                                                                                                    

" Another way to do <esc> Press ji
inoremap ji <Esc>

" UtilSnips Settings
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Undo settings
set undofile " Maintain undo history between sessions
set undodir=~/.cache/nvim/undo " Set persistent undo directory

" Improved incremental search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Improved incremental search - easymotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" Incremential fuzzy search and easymotion
" incsearch.vim x fuzzy x vim-easymotion

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
