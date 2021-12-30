set noexpandtab
set tabstop

let g:go_auto_type_info = 1

nnoremap <F10> :DlvToggleBreakpoint<CR>
nnoremap <F8> :!make api<CR>:DlvExec ./bin/api<CR>

nnoremap <F3> :GoImplements<CR>
