nnoremap <C-s> :r!date "+\%Y-\%m-\%d"<CR>A
inoremap <C-s> <Esc>:r!date "+\%Y-\%m-\%d"<CR>kddA
" autocmd BufWritePre *.dat execute "mark i" | execute "%LedgerAlign" | execute "normal 'i"
" autocmd BufWritePost *.dat call AutoCommit()
nnoremap { ?^\d<CR>
nnoremap } /^\d<CR>
vnoremap <silent> <buffer> <C-f> :LedgerAlign<CR>
vnoremap <silent> <buffer> <C-s> :'<,'>! hledger -f - print --sort 'date, amount'<CR>

let g:ledger_bin = 'hledger'
let g:ledger_maxwidth = 80
let g:ledger_fillstring = '    -'
let g:ledger_detailed_first = 1
let g:ledger_align_at = 60
