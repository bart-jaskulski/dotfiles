return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    opts = {
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024   -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Go to next function" },
            ["]a"] = { query = "@parameter.outer", desc = "Go to next argument/parameter" },
            ["]c"] = { query = "@comment.outer", desc = "Go to next comment" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Go to next function end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Go to previous function" },
            ["[a"] = { query = "@parameter.outer", desc = "Go to previous argument/parameter" },
            ["[c"] = { query = "@comment.outer", desc = "Go to previous comment" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@function.outer", desc = "Go to previous function end" },
          },
        }
      }
    },
    config = function(_, opts)
      require 'nvim-treesitter.configs'.setup(opts)
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        'nvim-treesitter/nvim-treesitter-context',
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
          mode = "cursor",
          max_lines = 3,
        },
      }
    }
  },
}
