let g:arduino_use_cli = 1
let g:arduino_dir = '/usr/share/arduino'
function! ArduinoStatusLine()
  let port = arduino#GetPort()
  let line = '[' . g:arduino_board . '] [' . g:arduino_programmer . ']'
  if !empty(port)
    let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
  endif
  return line
endfunction
let g:airline_section_x='%{ArduinoStatusLine()}'

nnoremap <leader>av :ArduinoVerify<CR>G
nnoremap <leader>au :ArduinoUpload<CR>G
nnoremap <leader>ab :ArduinoChooseBoard<CR>
nnoremap <leader>ap :ArduinoChoosePort<CR>
nnoremap <leader>as :ArduinoSerial<CR>G
" nnoremap <leader>ap :ArduinoChooseProgrammer<CR>

" noremap <buffer> <leader>aa <cmd>ArduinoAttach<CR>
" noremap <buffer> <leader>av <cmd>ArduinoVerify<CR>
" noremap <buffer> <leader>au <cmd>ArduinoUpload<CR>
" " noremap <buffer> <leader>aus <cmd>ArduinoUploadAndSerial<CR>
" noremap <buffer> <leader>as <cmd>ArduinoSerial<CR>
" noremap <buffer> <leader>ab <cmd>ArduinoChooseBoard<CR>
" noremap <buffer> <leader>ap <cmd>ArduinoChooseProgrammer<CR>
