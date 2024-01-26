"
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier']
\}
" Ledger {{{
" =========
" let g:ledger_bin = "ledger"
" }}}
" Unite.vim {{{
" =========

autocmd FileType unite setlocal shiftwidth=2 tabstop=2
autocmd FileType unite call compe#setup({'enabled': v:false}, 0)

let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
let g:unite_source_rec_async_command = ['ag', '--follow', '--nogroup', '--nocolor', '--hidden', '-g', '']

" ignore node_modules and bower_components
call unite#custom#source('file_rec', 'ignore_pattern', 'node_modules/\|bower_components/\|dist/\|elm-stuff/')

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
call unite#custom#profile('default', 'context', {
      \   'winheight': 20,
      \   'direction': 'dynamicbottom'
      \ })

" Initialize Unite's global list of menus
if !exists('g:unite_source_menu_menus')
  let g:unite_source_menu_menus = {}
endif

" Create an entry for our new menu of commands
let g:unite_source_menu_menus.bookmarks = {
      \    'description': 'Quick bookmarks and actions'
      \ }

" Define our list of [Label, Command] pairs
let g:unite_source_menu_menus.bookmarks.command_candidates = [
      \   ['vimrc                              [file]', 'e $HOME/.vim/vimrc'],
      \   ['js.snippets                        [file]', 'e $HOME/.vim/snippets/javascript/js.snippets'],
      \   ['----------------- Files -----------------', ''],
      \   ['Find in sources...              [command]', 'exe "Ag " input("pattern: ")'],
      \   ['Remove and close current file   [command]', 'call delete(expand("%")) | bdelete!'],
      \   ['New file here...                [command]', 'exe "e %:p:h/" . input("pattern: ")'],
      \   ['Rename file here...             [command]', 'exe "Rename %:p:h/" . input("pattern: ")'],
      \   ['New file here (split)...        [command]', 'exe "split %:p:h/" .  input("pattern: ")'],
      \   ['---------------- Commands ---------------', ''],
      \ ]

function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

" Unite key mappings
nnoremap <leader>f :<C-u>Unite -auto-resize -start-insert file_mru<cr>
" nnoremap <silent> <leader>r :call fzf#run({'source': 'git ls-files -c -o -x node_modules -x .expo', 'down': '30%', 'sink': 'e'})<cr>
nnoremap <silent> <leader>r :call fzf#run({'source': 'ag --hidden --ignore .git -g ""', 'down': '30%', 'sink': 'e'})<cr>
" nnoremap <leader>r :GitFiles<cr>
" nnoremap <leader>r :<C-u>Unite -auto-resize -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>e :<C-u>Unite -start-insert -buffer-name=buffer buffer<cr>
nnoremap <leader>b :<C-u>Unite -start-insert menu:bookmarks <cr>
nnoremap <leader>g :<C-u>Unite -auto-resize -buffer-name=files -start-insert file_rec:<C-r>=substitute(expand('%:h'), "\\", "\/", "g")<cr><cr>
" }}}
" Vim-airline {{{
let g:airline_theme="tomorrow"
set encoding=utf-8
" }}}
" Vim-arduino {{{
let g:arduino_use_cli = 1
" }}}
