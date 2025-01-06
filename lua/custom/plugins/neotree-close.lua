return {
  --  require('neo-tree').setup {
  --    event_handlers = {
  --
  --      {
  --        event = 'file_open_requested',
  --        handler = function()
  --          -- auto close
  --          vim.cmd.Neotree 'toggle'
  --          -- vimc.cmd 'Neotree close'
  --          -- OR
  --          -- require('neo-tree.command').execute { action = 'toggle' }
  --        end,
  --      },
  --    },
  --  },
}
