" ALE {{{
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'nix': ['nixfmt'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier']
\}
" }}}
"
" vim-fzf {{{
nnoremap <leader>g :Files %:h<cr>
nnoremap <leader>r :GFiles --cached --others --exclude-standard<cr>
nnoremap <leader>f :History<cr>
" }}}
"

" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Closetag files {{{
let g:closetag_filenames = "*.html,*.js,*.jsx,*.tsx"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
" }}}
