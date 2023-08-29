return {
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    dependencies = {
      'junegunn/fzf',
    },
    opts = {
      keymap = {
        fzf = {
          ["alt-space"] = "toggle",
          ["alt-a"] = "toggle-all",
        }
      },
      buffers = {
        cwd_only = true,
      },
      files = {
        fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude *.pot?"
      }
    }
  },
  {
    'Exafunction/codeium.vim',
    event = "InsertEnter",
    init = function()
      vim.g.codeium_no_map_tab = true
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require'treesitter'
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    }
  },
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require'lsp'
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'theHamsta/nvim-dap-virtual-text',
        config = function() require'nvim-dap-virtual-text'.setup() end,
      },
      {
        'leoluz/nvim-dap-go',
        config = function() require'dap-go'.setup() end,
      }
    },
    config = function()
      require'dap_config'
    end,
    keys = {
      { "<leader>gc" },
      { "<leader>gn", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>gi", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>go", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>gb", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>gt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>gC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      --       { "<leader>gl", function() require("dap").run_last() end, desc = "Run Last" },
      --       { "<leader>gp", function() require("dap").pause() end, desc = "Pause" },
      --       { "<leader>gr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      --       { "<leader>gs", function() require("dap").session() end, desc = "Session" },
      --       { "<leader>gw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require'git'
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    config = function()
      require'tree'
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      require'github-theme'.setup {
        options = {
          ["styles.comments"] = 'italic',
          transparent = true
        }
      }
      vim.cmd('colorscheme github_light')
    end,
  },
  {
    'ms-jpq/coq_nvim',
    event = "InsertEnter",
    branch = 'coq',
    build = ':COQdeps',
    init = function()
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        keymap = {
          recommended = false,
          jump_to_mark = "<M-space>",
        },
        clients = {
          lsp = { enabled = true },
          tree_sitter = { enabled = true },
          tags = { enabled = true },
          buffers = { enabled = false },
          tmux = { enabled = false },
          snippets = { enabled = false },
          registers = { enabled = false },
        }
      }
    end
  },
  {
    'ActivityWatch/aw-watcher-vim',
    pin = true
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'echasnovski/mini.sessions',
    config = function()
      local MiniSessions = require'mini.sessions'
      MiniSessions.setup()

      local is_something_shown = function()
        -- Don't autoread session if Neovim is opened to show something. That is
        -- when at least one of the following is true:
        -- - Current buffer has any lines (something opened explicitly).
        -- NOTE: Usage of `line2byte(line('$') + 1) > 0` seemed to be fine, but it
        -- doesn't work if some automated changed was made to buffer while leaving it
        -- empty (returns 2 instead of -1). This was also the reason of not being
        -- able to test with child Neovim process from 'tests/helpers'.
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
        if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then return true end

        -- - Several buffers are listed (like session with placeholder buffers). That
        --   means unlisted buffers (like from `nvim-tree`) don't affect decision.
        local listed_buffers = vim.tbl_filter(
          function(buf_id) return vim.fn.buflisted(buf_id) == 1 end,
          vim.api.nvim_list_bufs()
        )
        if #listed_buffers > 1 then return true end

        -- - There are files in arguments (like `nvim foo.txt` with new file).
        if vim.fn.argc() > 0 then return true end

        return false
      end
      local augroup = vim.api.nvim_create_augroup('MiniSessions', {})

      local autoread = function()
        if not is_something_shown() and vim.fn.getcwd():match('Repos') and vim.tbl_count(MiniSessions.detected) > 0 then
          MiniSessions.read()
        end
      end
      vim.api.nvim_create_autocmd(
        'VimEnter',
        { group = augroup, nested = true, once = true, callback = autoread, desc = 'Autoread latest session' }
      )

      local autowrite = function()
        if vim.v.this_session ~= '' and vim.fn.getcwd():match('Repos') then MiniSessions.write(nil, { force = true }) end
      end
      vim.api.nvim_create_autocmd(
        'VimLeavePre',
        { group = augroup, callback = autowrite, desc = 'Autowrite current session' }
      )
    end
  },
--   { 'stevearc/dressing.nvim' },
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     config = function()
--       require'lualine'.setup {}
--     end
--   }
--   {
--     "williamboman/mason.nvim",
--     setup = function()
--       require'mason'.setup()
--     end
--   }
}
