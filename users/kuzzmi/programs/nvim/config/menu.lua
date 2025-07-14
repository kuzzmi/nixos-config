-- Menu
-- Define the list of [Label, Command] pairs
-- prompt_and_search is defined in base.lua
local menu_items = {
  { label = 'Find in sources', command = function()
      prompt_and_search('')
    end
  },
  { label = 'New file here', command = function()
      vim.ui.input({ prompt = 'New file name: ' }, function(input)
        if input then vim.cmd('e ' .. vim.fn.expand('%:p:h/') .. '/' .. input) end
      end)
    end
  },
  { label = 'New file here (split)', command = function()
      vim.ui.input({ prompt = 'New file name: ' }, function(input)
        if input then vim.cmd('split ' .. vim.fn.expand('%:p:h/') .. '/' .. input) end
      end)
    end
  },
  { label = 'Rename file here', command = function()
      vim.ui.input({ prompt = 'Rename to: ', default = vim.fn.expand('%:p') }, function(input)
        if input then vim.cmd('Rename ' .. input) end
      end)
    end
  },
  { label = 'Remove and close current file', command = function()
      vim.cmd('call delete(expand("%")) | bdelete!')
    end
  },
  { label = '--- --- --- --- --- ---', command = function() end },
  { label = 'Git blame', command = function()
      vim.cmd('Git blame')
    end
  },
}

-- Function to present the menu and execute the selected command
function show_my_menu()
  -- Extract labels from menu items
  local labels = {}
  for _, item in ipairs(menu_items) do
    table.insert(labels, item.label)
  end

  -- Use vim.ui.select to present the menu
  vim.ui.select(labels, { prompt = 'Select an option:' }, function(choice)
    if choice then
      -- Find the corresponding command for the selected choice
      for _, item in ipairs(menu_items) do
        if item.label == choice and item.command then
          -- Execute the command function
          item.command()
        end
      end
    end
  end)
end

-- Create a normal mode key mapping to trigger the show_my_menu function
vim.api.nvim_set_keymap('n', '<leader>b', ':lua show_my_menu()<CR>', { noremap = true, silent = true })
