local function edit_or_open()
  local api = require "nvim-tree.api"
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
    -- Close the tree if file was opened
    api.tree.close()
  end
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'l', edit_or_open, opts('Edit or Open'))
  vim.keymap.set('n', 'h', api.tree.collapse_all, opts('Close'))
end

return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    opts = {
      on_attach = my_on_attach,
      sort_by = "case_sensitive",
      view = { width = 25, },
      renderer = { group_empty = true, },
      filters = { dotfiles = true, },
      sync_root_with_cwd = true,
      hijack_cursor = true,
      actions = {
        change_dir = {
          restrict_above_cwd = true
        }
      }
    },
  },
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    dependencies = { 'junegunn/fzf', },
    opts = {
      keymap = {
        fzf = {
          ["alt-space"] = "toggle",
          ["alt-a"] = "toggle-all",
        }
      },
      buffers = { cwd_only = true, },
      grep = { multiline = 1 },
    }
  },
  {
    'echasnovski/mini.diff',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      view = {
        style = 'sign',
        signs = {
          add    =  '┃',
          delete =  '_',
          change =  '~',
        }
      },
    },
  },
  {
    'echasnovski/mini.jump',
    event = "VeryLazy",
    config = true
  }
}
