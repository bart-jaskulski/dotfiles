return {
  {
    'echasnovski/mini.sessions',
    config = function()
      local MiniSessions = require'mini.sessions'
      MiniSessions.setup({ autoread = false })

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
        -- Use BufEnter to prevent loosing data on vim fuckups
        { 'BufEnter', 'VimLeavePre' },
        { callback = autowrite, desc = 'Autowrite current session' }
      )
    end
  },
  {
    'echasnovski/mini.hipatterns',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = function()
      local hi = require("mini.hipatterns")
      return {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color(),
        },
      }
    end,
  },
}
