return {
  {
    'Exafunction/codeium.vim',
    event = "InsertEnter",
    cmd = "Codeium",
    build = ":Codeium Auth",
    init = function()
      vim.g.codeium_no_map_tab = true
    end
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
}
