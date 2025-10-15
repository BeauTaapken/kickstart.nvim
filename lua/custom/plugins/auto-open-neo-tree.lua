return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    init = function()
      -- Mirror your current behavior: open once on first BufWinEnter
      local group = vim.api.nvim_create_augroup('neotree_autoopen', { clear = true })
      vim.api.nvim_create_autocmd('BufWinEnter', {
        group = group,
        desc = 'Open Neo-tree by default (first window only)',
        callback = function(args)
          if vim.g.neotree_opened then
            return
          end
          -- Avoid re-entering when the window *is* Neo-tree or other side UIs
          local ft = vim.bo[args.buf].filetype
          if ft == 'neo-tree' or ft == 'lazy' or ft == 'starter' then
            return
          end

          vim.g.neotree_opened = true
          vim.cmd 'Neotree show'
        end,
      })
    end,
  },
}
