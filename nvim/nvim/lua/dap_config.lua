local dap = require('dap')

local continue = function()
  if vim.fn.filereadable('.vscode/launch.json') then
    require('dap.ext.vscode').load_launchjs()
  end
  require('dap').continue()
end

vim.keymap.set('n', '<leader>gc', continue)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

vim.api.nvim_set_hl(0, 'DebugBreakpoint', {bg='#e4b7be'})
vim.api.nvim_set_hl(0, 'debugPC', { default = true, link = 'Visual' })

vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg', linehl='DebugBreakpoint', numhl=''})

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/bjaskulski/Repos/github.com/xdebug/vscode-php-debug/out/phpDebug.js' }
}

-- dap.adapters.go = {
--   type = 'executable',
--   command = 'node',
--   args = {'/home/bjaskulski/Repos/github.com/golang/vscode-go/dist/debugAdapter.js'},
-- }

dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/github.com/firefox-devtools/vscode-firefox-debug/dist/adapter.bundle.js'},
}

dap.configurations.typescript = {
  {
  name = 'Debug with Firefox',
  type = 'firefox',
  request = 'launch',
  reAttach = true,
  url = 'http://localhost:3000',
  webRoot = '${workspaceFolder}',
  firefoxExecutable = '/usr/bin/firefox'
  }
}

-- dap.configurations.go = {
--   {
--     type = 'go',
--     name = 'Debug',
--     request = 'launch',
-- --     showLog = false,
--     program = "${file}",
--     dlvToolPath = "/home/bjaskulski/go/bin/dlv"
--   },
-- }

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    pathMappings = {
      ['/var/www/html'] = "/home/bjaskulski/Templates/WordPress",
      ['/var/www/html/wp-content/plugins/woocommerce'] = "/home/bjaskulski/Plugins/woocommerce",
      ['/var/www/html/wp-content/plugins/flexible-subscriptions'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-subscriptions",
      ['/var/www/html/wp-content/plugins/flexible-wishlist'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-wishlist",
      ['/var/www/html/wp-content/plugins/flexible-wishlist-analytics'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/flexible-wishlist-analytics",
      ['/var/www/html/wp-content/plugins/shopmagic-for-woocommerce'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-for-woocommerce",
      ['/var/www/html/wp-content/plugins/shopmagic-woocommerce-bookings'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/shopmagic-woocommerce-bookings",
      ['/var/www/html/wp-content/plugins/woocommerce-bookings'] = "/home/bjaskulski/Plugins/woocommerce-bookings",
      ['/var/www/html/wp-content/plugins/woocommerce-subscriptions'] = "/home/bjaskulski/Plugins/woocommerce-subscriptions",
      ['/var/www/html/wp-content/plugins/wp-desk-omnibus'] = "/home/bjaskulski/Repos/gitlab.wpdesk.dev/wp-desk-omnibus",
    },
    stopOnEntry = false
  }
}
