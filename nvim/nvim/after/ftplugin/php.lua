vim.opt.tags:append {
  '~/Templates/WordPress/tags',
  '~/Plugins/woocommerce/tags',
}
vim.opt.keywordprg = 'rdr https://php.net/'

if vim.fn.executable('vendor/bin/phpcbf') == 1 then
  vim.opt.formatprg = 'vendor/bin/phpcbf --stdin-path=% -'
end
