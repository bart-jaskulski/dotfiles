local gs = require('gitsigns')
gs.setup{
  on_attach = function(bufnr)
    
    -- Navigation
    vim.keymap.set('n', ']g', function()
      if vim.wo.diff then return ']g' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true, desc='Go to next change'})

    vim.keymap.set('n', '[g', function()
      if vim.wo.diff then return '[g' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true, desc='Go to previous change'})

    vim.keymap.set('n', '[G', function()
      if vim.wo.diff then return '[G' end
      vim.schedule(function()
        vim.api.nvim_win_set_cursor(0, {1, 0})
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, {expr=true, desc='Go to first change'})

    vim.keymap.set('n', ']G', function()
      if vim.wo.diff then return ']G' end
      vim.schedule(function() 
        vim.api.nvim_win_set_cursor(0, {-1, 0})
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, {expr=true, desc='Go to last change'})
  end
}
