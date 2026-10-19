-- Auto-open Neo-tree once at startup
local group = vim.api.nvim_create_augroup('neotree_autoopen', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  desc = 'Open Neo-tree by default on startup',
  callback = function()
    if vim.g.neotree_opened then
      return
    end
    vim.g.neotree_opened = true
    vim.cmd 'Neotree show'
  end,
})
