require('plugins')
require('options')
require('keymapping')
require('colorscheme')

require('plugins.lsp.mason')
---------------------
--Global Varialbles--
---------------------

vim.g.airline_powerline_font = true
vim.g.easyescape_chars = {
  j = 1,
  k = 1
}
vim.g.easyescape_timeout  = 100
