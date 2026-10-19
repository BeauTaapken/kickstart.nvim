-- lua/custom/plugins/neo-tree-config.lua
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    require('neo-tree').setup {
      close_if_last_window = true,
    }

    -- Skip auto-open when nvim was launched with a directory argument
    -- (e.g. `nvim ./` or `nvim some/dir`), since netrw hijack duplicates the tree
    local args = vim.fn.argv()
    for _, a in ipairs(args) do
      if vim.fn.isdirectory(vim.fn.fnamemodify(a, ':p')) == 1 then
        return
      end
    end

    vim.cmd 'Neotree show'
  end,
})
