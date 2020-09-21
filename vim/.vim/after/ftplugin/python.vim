" Black settings
let g:black_linelength = 100
autocmd BufWritePre *.py silent! execute ':Black'
