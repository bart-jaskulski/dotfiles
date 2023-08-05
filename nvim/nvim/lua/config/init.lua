local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require'config.options'
require'ministatusline'.setup()

if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
      pattern = "VeryLazy",
      callback = function()
        vim.api.nvim_set_hl(0, 'SpellBad', {default=true,fg='#d1242f', underline=true})
        require("config.autocmds")
        require("config.keymaps")
      end,
    })
  else
    -- load them now so they affect the opened buffers
    vim.api.nvim_set_hl(0, 'SpellBad', {default=true, fg='#d1242f', underline=true})
    require("config.autocmds")
    require("config.keymaps")
end

require'lazy'.setup("plugins", {
  change_detection = {
    enabled = false
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
--         "matchit",
--         "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      }
    }
  }
})
