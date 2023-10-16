local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "text" },
  callback = function(ev)
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.keymap.set("n", "j", "gj", { remap = true, buffer = ev.buf })
    vim.keymap.set("n", "k", "gk", { remap = true, buffer = ev.buf })
    vim.keymap.set("i", "--<space>", "–<space>", { buffer = ev.buf })
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- show cursor line only in active window
if os.getenv('DISPLAY') ~= nil then
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter", "WinEnter" }, {
    command = "if ! &cursorline && ! &pvw | setlocal cursorline | endif",
  })
  vim.api.nvim_create_autocmd({ "InsertEnter", "BufLeave", "WinLeave" }, {
    command = "if &cursorline && ! &pvw | setlocal nocursorline | endif",
  })
end

-- some tweaks for terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  command = "startinsert | setlocal nonumber norelativenumber nocursorline signcolumn=no",
})
