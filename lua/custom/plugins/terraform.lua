return {
  -- 1) Treesitter: add terraform + hcl parsers
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      for _, lang in ipairs { 'terraform', 'hcl' } do
        if not vim.tbl_contains(opts.ensure_installed, lang) then
          table.insert(opts.ensure_installed, lang)
        end
      end
      return opts
    end,
  },

  -- 2) LSP: extend Kickstart's lsp plugin (no direct lspconfig.setup)
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts = opts or {}
      opts.servers = opts.servers or {}
      -- Kickstart will call lspconfig for you using this table
      opts.servers.terraformls = {
        filetypes = { 'terraform', 'terraform-vars', 'hcl' },
      }
      return opts
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, 'terraformls') then
        table.insert(opts.ensure_installed, 'terraformls')
      end
      return opts
    end,
  },

  -- 3) Formatting: terraform fmt via conform.nvim
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts = opts or {}
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.terraform = { 'terraform_fmt' }
      opts.formatters_by_ft['terraform-vars'] = { 'terraform_fmt' }
      opts.formatters_by_ft.hcl = { 'terraform_fmt' }
      return opts
    end,
  },

  -- 4) Linting: tflint via nvim-lint (fixed require + callback)
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft.terraform = { 'tflint' }
      lint.linters_by_ft['terraform-vars'] = { 'tflint' }

      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },

  -- (Optional) 5) Auto-install CLI tools like tflint
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = { 'tflint', 'terraform-ls' }, -- terraform-ls is harmless if already installed
      run_on_start = true,
      auto_update = false,
    },
  },
}
