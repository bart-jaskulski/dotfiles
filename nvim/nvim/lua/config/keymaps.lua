-- Leaderkey
-- vim.keymap.set('n', '<leader>f', '<cmd>FZF<cr>', { desc = 'Open file picker at current working directory' })
-- vim.keymap.set('n', '<leader>b', '<cmd>Buffers<cr>', { desc = 'Open buffer picker' })
-- vim.keymap.set('n', '<leader>j', '<cmd>Jumps<cr>', { desc = 'Open jumplist picker' })
-- vim.keymap.set('n', '<leader>/', '<cmd>RG<cr>', { desc = 'Global search in workspace folder' })
vim.keymap.set('n', '<leader>f', '<cmd>lua require("fzf-lua").files()<cr>', { desc = 'Open file picker', silent = true })
vim.keymap.set('n', '<leader>F', '<cmd>lua require("fzf-lua").files({cwd = "%:p:h"})<cr>', { desc = 'Open file picker at current working directory', silent = true })
vim.keymap.set('n', '<leader>b', '<cmd>lua require("fzf-lua").buffers()<cr>', { desc = 'Open buffer picker', silent = true })
vim.keymap.set('n', '<leader>j', '<cmd>lua require("fzf-lua").jumps()<cr>', { desc = 'Open jumplist picker' })
vim.keymap.set('n', '<leader>/', '<cmd>lua require("fzf-lua").live_grep()<cr>', { desc = 'Global search in workspace folder' })
vim.keymap.set('n', '<leader>s', '<cmd>lua require("fzf-lua").lsp_document_symbols()<cr>', { desc = 'Open symbol picker' })
vim.keymap.set('n', '<leader>d', '<cmd>lua require("fzf-lua").lsp_document_diagnostics()<cr>', { desc = 'Open diagnostic picker' })
vim.keymap.set('n', "<leader>'", '<cmd>FzfLua<cr>', { desc = 'Open picker' })

--- Bracket navigation
-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto next diagnostic' })
vim.keymap.set('n', '[D', function()
  vim.diagnostic.goto_next{cursor_position = { 1, 0 } }
end, { desc = 'Go to first diagnostic in document' })
vim.keymap.set('n', ']D', function()
  vim.diagnostic.goto_prev{cursor_position = { -1, 0 } }
end, { desc = 'Go to last diagnostic in document' })
-- Quickfix list mappings
vim.keymap.set("n", "[q", ":cprevious<CR>", { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { desc = "First quickfix" })
vim.keymap.set("n", "]Q", ":clast<CR>", { desc = "Last quickfix" })
-- Location list mappings
vim.keymap.set("n", "[l", ":lprevious<CR>", { desc = "Previous location" })
vim.keymap.set("n", "]l", ":lnext<CR>", { desc = "Next location" })
vim.keymap.set("n", "[L", ":lfirst<CR>", { desc = "First location" })
vim.keymap.set("n", "]L", ":llast<CR>", { desc = "Last location" })

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.keymap.set('n', 'ga', '<cmd>:b#<cr>', { desc = 'Go to alternate file' })
vim.keymap.set('n', 'gn', '<cmd>:bn<cr>', { desc = 'Go to next buffer' })
vim.keymap.set('n', 'gp', '<cmd>:bp<cr>', { desc = 'Go to previous buffer' })

local user_lsp_group = vim.api.nvim_create_augroup('UserLspConfig', {})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = user_lsp_group,
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.bo[ev.buf].formatexpr = 'v:lua.vim.lsp.formatexpr()'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    local function on_list(options)
      -- I prefer location list over quickfix, because you can have
      -- multiple of them
      vim.fn.setloclist(0, {}, ' ', options)
      vim.api.nvim_command('lopen')
    end

    -- LSP goto
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', function ()
      vim.lsp.buf.definition{on_list=on_list}
    end, opts)
    vim.keymap.set('n', 'gr', function()
      vim.lsp.buf.references(nil, {on_list=on_list})
    end, opts)
    vim.keymap.set('n', 'gi', function()
      vim.lsp.buf.implementation{on_list=on_list}
    end, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)

    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
    --     vim.keymap.set('n', '<space>f', function()
    --       vim.lsp.buf.format { async = true }
    --     end, opts)

    vim.api.nvim_create_autocmd('CursorHold', {
      group = user_lsp_group,
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.document_highlight()
      end
    })

    vim.api.nvim_create_autocmd('CursorHoldI', {
      group = user_lsp_group,
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.document_highlight()
      end
    })

    vim.api.nvim_create_autocmd('CursorMoved', {
      group = user_lsp_group,
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.clear_references()
      end
    })
  end,
})

vim.keymap.set('n', '<leader><TAB>', function ()
  require'nvim-tree.api'.tree.toggle()
end, { desc = 'Toggle file explorer' })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { silent = true, desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { silent = true, desc = "Move up" })
vim.keymap.set("n", "<A-h>", "<<", { silent = true, desc = "Move left" })
vim.keymap.set("n", "<A-l>", ">>", { silent = true, desc = "Move right" })
-- vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })


-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({"n", "x", "o"}, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set({"n", "x", "o"}, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set('n', '<leader>x', '<cmd>q<cr>', { desc = 'Close buffer' })

vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })

-- vim.keymap.set('i', '<Tab>', function ()
--   return vim.fn.pumvisible() == 1 and '<C-y>' or vim.cmd('call codeium#Accept()')
-- end, { desc = 'Insert completion', expr = true, silent = true })

-- Keep matches center screen when cycling with n|N
vim.keymap.set("n", "n", "nzzzv", { desc = "Fwd  search '/' or '?'" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Back search '/' or '?'" })
