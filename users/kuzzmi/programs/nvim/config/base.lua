function search_for_current_word()
  local default_word = vim.fn.expand('<cword>')
  prompt_and_search(default_word)
end

vim.api.nvim_set_keymap('n', '<leader>s', ':lua search_for_current_word()<CR>', { noremap = true, silent = true })
