" Black settings
let g:black_linelength = 100
autocmd BufWritePre *.py silent! execute ':Black'

" Ale settings
let g:ale_completion_enabled = 1
