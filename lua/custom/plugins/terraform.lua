-- 1) Treesitter: install terraform + hcl parsers
-- kickstart's vim.pack treesitter setup does not use ensure_installed;
-- the new API is require('nvim-treesitter').install { ... }
require('nvim-treesitter').install({ 'terraform', 'hcl' })

-- 2) LSP: terraformls
-- kickstart's vim.pack init.lua defines a `servers` table and then calls
-- vim.lsp.config / vim.lsp.enable. You must add to that table in init.lua,
-- or define the server yourself here:
vim.lsp.config('terraformls', {
  filetypes = { 'terraform', 'terraform-vars', 'hcl' },
})
vim.lsp.enable('terraformls')

-- 3) Formatting: terraform_fmt via conform.nvim
-- kickstart may already require('conform').setup { ... }. Calling setup again
-- would overwrite it. If kickstart's conform config is accessible, mutate it
-- before setup; otherwise provide your own full setup:
require('conform').setup {
  formatters_by_ft = {
    terraform = { 'terraform_fmt' },
    ['terraform-vars'] = { 'terraform_fmt' },
    hcl = { 'terraform_fmt' },
  },
}

-- 4) Linting: tflint via nvim-lint
local lint = require 'lint'
lint.linters_by_ft = lint.linters_by_ft or {}
lint.linters_by_ft.terraform = { 'tflint' }
lint.linters_by_ft['terraform-vars'] = { 'tflint' }

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

-- 5) Auto-install CLI tools
-- mason-tool-installer still works with vim.pack; add it and call setup
vim.pack.add { 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' }
require('mason-tool-installer').setup {
  ensure_installed = { 'tflint', 'terraform-ls' },
  run_on_start = true,
  auto_update = false,
}
