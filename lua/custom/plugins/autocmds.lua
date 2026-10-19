local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup 'autoupdate',
  callback = function()
    if vim.fn.exists(':Lazy') == 1 then
      vim.cmd('Lazy update')
    end
  end,
})

return {}
