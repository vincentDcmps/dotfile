require('options')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
require('keymapping')

require('colorscheme')

---------------------
--Global Varialbles--
---------------------
--
vim.filetype.add({
  pattern = {
    [".*/tasks/.*.ya?ml"] = "yaml.ansible",
    [".*/ansible/.*.ya?ml"] = "yaml.ansible",
    [".*/.nomad.hcl"] = "nomad",
    [".*.nomad"] = "nomad",

  },
})

vim.g.airline_powerline_font = true
