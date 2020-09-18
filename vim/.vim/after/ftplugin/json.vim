let g:indentLine_char = '⦙'
set foldmethod=syntax
set foldlevelstart=20
autocmd BufWinEnter * silent! :%foldopen!
