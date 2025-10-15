-- Force Lazy.nvim to use SSH for GitHub (avoids HTTPS credential prompts)
local ok, Config = pcall(require, 'lazy.core.config')
if ok and Config.options and Config.options.git then
  Config.options.git.url_format = 'git@github.com:%s.git'
end
return {}
