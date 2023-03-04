require('plugins')
require('options')
require('keymapping')
require('colorscheme')

require('plugins.lsp.mason')
---------------------
--Global Varialbles--
---------------------
--
vim.filetype.add({
  pattern = {
    [".*/tasks/.*.ya?ml"] = "yaml.ansible",
    [".*/ansible/.*.ya?ml"] = "yaml.ansible"
  },
})

vim.g.airline_powerline_font = true
vim.g.easyescape_chars = {
  j = 1,
  k = 1
}
vim.g.easyescape_timeout  = 100
