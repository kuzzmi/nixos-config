local function prompt_and_search(default)
  vim.ui.input({ prompt = 'Enter search term: ', default = default }, function(input)
    if input then
      vim.cmd('Ag ' .. vim.fn.escape(input, ' '))
    else
      print('No search term provided')
    end
  end)
end


