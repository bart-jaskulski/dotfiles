return {
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      require 'github-theme'.setup {
        options = {
          ["styles.comments"] = 'italic',
          transparent = true,
          dim_inactive = true
        }
      }
      vim.cmd('colorscheme github_light')
    end,
  },
}
