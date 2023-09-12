require('pluginsLazy')
require('options')
require('keymapping')
require('colorscheme')

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
