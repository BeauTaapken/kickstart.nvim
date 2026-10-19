-- Ensure Neo-tree keeps close_if_last_window = true (overrides kickstart default)
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    require('neo-tree').setup {
      close_if_last_window = true,
    }
  end,
})
