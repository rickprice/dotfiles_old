" These were generally required in the past, but may not be anymore
set nocompatible              " be iMproved, required
filetype off                  " required

" Set leader key
let mapleader = "\<Space>"

" Determine if this is a host with enough oomph to run advanced things (IE not
" a phone)
let g:advanced_hosts = ["fpersonal","fwork"]
let g:is_advanced_host = 0
if index(g:advanced_hosts, hostname()) >= 0
    let g:is_advanced_host = 1
endif

" Determine various things about our environment
let g:is_nvim = has('nvim')
let g:is_nvim5 = has('nvim-0.5.0')
let g:is_vim = !g:is_nvim
let g:is_vim8 = v:version >= 800 && g:is_vim ? 1 : 0
let g:has_python3 = has('python3')
let g:use_coc = g:is_nvim5 || g:is_vim8
let g:has_rust_cargo = executable('cargo')
let g:is_windows = has('win32')

" +++++++++++++++++++++++++++++++ Start of Vim-Plug auto-download +++++++++++++++++++++++++++++++
" On Windows the NeoVim configuration file init.vim goes to %USERPROFILE%/AppData/Local/nvim/init.vim
" On Windows the Vim configuration file init.vim goes to %USERPROFILE%/vimfiles/vimrc
let g:xdg_config_home = $XDG_CONFIG_HOME
let g:xdg_data_home = $XDG_DATA_HOME
let g:plug_github_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
let g:autoload_plug = '/autoload/plug.vim'

" Figure out where the plug-vim and plugin files go
" Note that $HOME is a somewhat magic variable that is fixed up on Windows for
" us
if g:is_vim
    if has('win32')
        let g:plug_location = $HOME . '/vimfiles'
        let g:plugin_location=''
    else
        let g:plug_location = $HOME . '/.vim'
        let g:plugin_location = ''
    endif
else
    " For Neovim here, we also take the XDG locations into account if they are
    " defined
    if has('win32')
        let g:plug_location = $HOME . '/AppData/Local/nvim/vimfiles'
        let g:plugin_location = ''
    else
        if len(g:xdg_data_home) == 0
            let g:plug_location = $HOME . '/.local/share/nvim/site'
        else
            let g:plug_location= g:xdg_data_home . '/nvim/site'
        endif
        if len(g:xdg_data_home) == 0
            let g:plugin_location = $HOME . '/.local/shared/nvim/plugged'
        else
            let g:plugin_location = g:xdg_data_home . '/nvim/plugged'
        endif
    endif
endif

" Download Plug plugin for (Neo)vim
if empty(glob(g:plug_location . g:autoload_plug))
    execute '!curl -fLo ' . g:plug_location . g:autoload_plug . ' --create-dirs ' . g:plug_github_url
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" If our plugin location is defined, then call plug#begin with it
if len(g:plugin_location) == 0
    call plug#begin()
else
    call plug#begin(g:plugin_location)
endif

" ========== Put your plugins here ==========


" ========== Put your plugins here ==========
" Use the below to finish your plugins (uncomment)
"call plug#end()
" +++++++++++++++++++++++++++++++ End of Vim-Plug auto-download +++++++++++++++++++++++++++++++

if g:use_coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
    if g:is_vim8 || g:is_nvim
        Plug 'psf/black', { 'for' : 'python' }
        Plug 'w0rp/ale'
    endif
endif

Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-plug'
Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-indent'
Plug 'jceb/vim-textobj-uri'
Plug 'thinca/vim-textobj-between'

" Gives powerful text objects and jumping based on the language you are in
Plug 'andymass/vim-matchup'

Plug 'mileszs/ack.vim'


" Motion plugins
Plug 'easymotion/vim-easymotion'
" Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'


Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'masukomi/vim-markdown-folding', { 'for' : 'markdown' }
" Very powerful text objects plugin
Plug 'wellle/targets.vim'

Plug 'tommcdo/vim-exchange'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'pedrohdz/vim-yaml-folds'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

"UltiSnips engine
if g:has_python3 || g:is_nvim5
    " Track the engine.
    Plug 'SirVer/ultisnips'

    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'

    "Snippets for use by ActiveState BE
    Plug 'rickprice/be-ultisnips-snippets'

    " Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
    " - https://github.com/Valloric/YouCompleteMe
    " - https://github.com/nvim-lua/completion-nvim
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

    " Load Ultisnips user configuration
    source ~/.config/nvim/ultisnips.vim
endif

if g:has_python3
    "Mundo requires python >=2.4, but we only use Python3
    Plug 'simnalamburt/vim-mundo'
endif

" Plugin to handle CSV format files
Plug 'chrisbra/csv.vim'

" Improved incremental search
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" Vim Sensible
Plug 'tpope/vim-sensible'

" Fern
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
if !g:is_windows
    Plug 'LumaKernel/fern-mapping-fzf.vim'
endif
Plug 'lambdalisue/fern-mapping-git.vim'
Plug 'lambdalisue/fern-git-status.vim'

if g:is_advanced_host && g:is_nvim && g:has_rust_cargo
    " Todoist and Clap
    Plug 'romgrk/todoist.nvim', { 'do': ':TodoistInstall' }

    let g:todoist = {
    \ 'icons': {
    \   'unchecked': ' [ ] ',
    \   'checked':   ' [X] ',
    \   'loading':   '  ',
    \   'error':     '  ',
    \ },
    \  'defaultProject': 'WorkVimTodos',
    \  'useMarkdownSyntax': v:true,
    \}

    let clap_provider_todoist = {
    \ 'source': {-> Todoist__listProjects()},
    \ 'sink': 'Todoist',
    \}
endif

" The bang version will try to download the prebuilt binary if cargo does not exist.
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
let g:clap_theme = 'material_design_dark'

" Neovim Bugfix
if is_nvim
    Plug 'antoinemadec/FixCursorHold.nvim'
endif

" Colour Schemes
" - Color support plugins
" Clap (which is loaded) also has colorscheme switching
"Plug 'xolox/vim-colorscheme-switcher'
"Plug 'xolox/vim-misc'
"Plug 'vim-scripts/colorsupport.vim'

" - Color plugins
Plug 'romainl/vim-dichromatic'
Plug 'humanoid-colors/vim-humanoid-colorscheme'

"Plug 'rakr/vim-one'
"Plug 'challenger-deep-theme/vim'

"This is for you Noah
"Plug 'dracula/vim', { 'as': 'dracula' }


call plug#end()

" Color Scheme setup
if g:is_nvim || has('termguicolors')
    set termguicolors
endif

":colorscheme one
":set background=dark

":colorscheme challenger_deep
":set background=dark

":colorscheme humanoid
":set background=dark
":set background=light

" gVim would have 'gui_running'
" We silently ignore failures on the colorscheme, this is because they may not
" be loaded yet when (Neo)Vim first loads the configuration
if has("gui_running")
    :silent! colorscheme humanoid
    :set background=light
else
"    :colorscheme challenger_deep
    :silent! colorscheme dichromatic
    :set background=dark
endif

" Hey Noah, this is for you...
":colorscheme dracula
":set background=dark

" ZFZ Setup
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
set grepprg=rg\ --vimgrep\ --smart-case\ --follow



" CoC Setup
if g:use_coc
    let g:coc_global_extensions = ['coc-pyright', 'coc-yaml', 'coc-json', 'coc-git', 'coc-docker', 'coc-markdownlint', 'coc-perl', 'coc-sh', 'coc-fzf-preview', 'coc-spell-checker','coc-tsserver', 'coc-rls', 'coc-ultisnips']

    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
"    set cmdheight=2
    set cmdheight=1

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
    if g:is_nvim
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

" CoC Setup
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

" Toggle line number display
nnoremap <F2> :let [&nu, &rnu] = [!&rnu, &nu+&rnu==1]<cr>

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
set tabstop=8       " Tabstops need to be 8 to keep things sane

set autoindent      "Keep indentation from previous line
set smartindent     "Automatically inserts indentation in some cases
set cindent         "Like smartindent, but stricter and more customisable

" Better word wrappping
let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction
map <leader>w :call ToggleWrap()<CR>

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

" Undo settings
set undofile " Maintain undo history between sessions
set undodir=~/.cache/nvim/undo " Set persistent undo directory
set undolevels=10000

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

" Move current line
nnoremap <C-j> :m+<cr>
nnoremap <C-k> :m-2<cr>

" Delete trailing whitespace
noremap <leader>dtw :%s/\s\+$//e<cr>

" For tracking what is going on in Vim
function! ToggleVerbose()
    if !&verbose
        call mkdir($HOME . "/.cache/vim/logs", "p", 0700)
        set verbosefile=~/.cache/vim/logs/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction

" Create a scroll mode from Reddit
fun! Scroll_mode()  " {{{
    let keymap = {
        \ 'k': "\<C-y>", 'K': "\<C-u>",
        \ 'j': "\<C-e>", 'J': "\<C-d>",
        \ 'h': "\<C-B>", 'H': "\<C-B>",
        \ 'l': "\<C-F>", 'L': "\<C-F>"}
    while v:true
        let char = nr2char(getchar())
        if ! has_key(keymap, char) | break | endif
            execute "normal " . expand(keymap[char])
        redraw
    endw
    execute "normal M"
    echo
endfun  " }}}
nnoremap gs :call Scroll_mode()<CR>

" Spell checking, set to en_ca and turn off by default
set spell spelllang=en_ca
set nospell
nnoremap <leader>s :set spell!<cr>

" ------------------------------------------------------------------------------
" FileType mappings
augroup filetype_yaml
  autocmd!

  " Setup shifts and tabstops etc for YAML files
  autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>

" To get this effect for a single file you can add this to the top of a file:
" # vim: set shiftwidth=2 tabstop=2 softtabstop=2 expandtab:
"
" To change files that have a mix of tabs and spaces to all spaces
" In VIM's command mode enter the following
" :set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
" :retab
augroup END

augroup filetype_json
  autocmd!

  autocmd FileType json setlocal foldmethod=syntax
augroup END

augroup filetype_csv
  autocmd!

  " Format the columns more nicely when CSV buffer loads
  autocmd BufRead,BufWritePost *.csv execute ":%ArrangeColumn!"
  autocmd BufWritePre *.csv execute ":%UnArrangeColumn"
augroup END

augroup filetype_perl
  autocmd!

  autocmd BufWritePost perl silent! !tidyall %:p
augroup END

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
