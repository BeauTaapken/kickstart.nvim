local term_group = vim.api.nvim_create_augroup('autoterm_open', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = term_group,
  callback = function()
    vim.schedule(function()
      -- Don't create a terminal if one is already visible
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == 'terminal' then
          return
        end
      end

      -- Find the main editor window (not Neo-tree / lazy / starter)
      local target_win
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype
        if ft ~= 'neo-tree' and ft ~= 'lazy' and ft ~= 'starter' and vim.bo[buf].buftype == '' then
          target_win = win
          break
        end
      end

      if not target_win then
        return
      end

      local prev_win = vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_win(target_win)
      vim.cmd('below terminal')
      vim.cmd('resize 10')
      vim.api.nvim_set_current_win(prev_win)
    end)
  end,
})
