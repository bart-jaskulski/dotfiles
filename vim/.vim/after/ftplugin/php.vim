vim9script

set tags+=~/Templates/WordPress/tags,~/Plugins/woocommerce
set keywordprg=rdr\ https://php.net/\

# builtin php syntax highlighing customization
g:php_sql_query = 1
g:php_htmlInStrings = 2
g:php_parent_error_close = 1
g:php_parent_error_open = 1
g:php_folding = 1

# Add class methods abbreviations similar to phpstorm
iabbrev pubf public function
iabbrev prif private function
iabbrev prof protected function
iabbrev pubsf public static function
iabbrev prisf private static function
iabbrev prosf protected static function

# au FileType php {
#   set formatprg=phpcbf\ --stdin-path=%\ -
# # set makeprg=XDEBUG_MODE=off\ phpstan\ analyse\ src\ --no-progress\ --error-format=raw\ --no-interaction\ &&\ phpcs\ -q\ --report=emacs
# }

# au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags &'
