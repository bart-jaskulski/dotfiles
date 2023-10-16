-- Setup language servers.
local lspconfig = require('lspconfig')

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = true
  },
  update_in_insert = false,
  signs = {
    active = signs
  },
  severity_sort = true,
  --   float = {
  --     focusable = false,
  --     style = "minimal",
  --     border = "rounded",
  --     source = "always",
  --     header = "",
  --     prefix = "",
  --   },
})

lspconfig.phpactor.setup(
  require'coq'.lsp_ensure_capabilities({
    --cmd = {'php', '-d xdebug.mode=debug', '/home/bjaskulski/bin/phpactor', 'language-server' },
    cmd = { '/home/bjaskulski/Repos/github.com/phpactor/phpactor/build/phpactor.phar', 'language-server' },
    root_dir = function(fname)
      return lspconfig.util.root_pattern('composer.json', '.git', '.phpactor.yml', '.phpactor.json')(fname)
    end
  })
)

-- lspconfig.vuels.setup{}
lspconfig.volar.setup{}
lspconfig.tsserver.setup{}
lspconfig.gopls.setup{}
lspconfig.clangd.setup{}

lspconfig.lua_ls.setup(
  require'coq'.lsp_ensure_capabilities({
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      }
  })
)
