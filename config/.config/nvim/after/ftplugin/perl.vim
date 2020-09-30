" Ale settings
let g:ale_completion_enabled = 1

autocmd BufWritePost * silent! !tidyall %:p &
