require('plugins')


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
-------------
-- Options --
-- ----------

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.smartcase = true
vim.opt.mouse = 'a'
vim.opt.background = 'dark'
vim.opt.tabstop= 2
vim.opt.softtabstop = 2 vim.opt.shiftwidth= 2 vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.copyindent= true
vim.opt.termguicolors = true
vim.cmd([[colorscheme gruvbox]])


---------------------
--Global Varialbles--
---------------------

vim.g.airline_powerline_font = true
vim.g.easyescape_chars = {
  j = 1,
  k = 1
}
vim.g.easyescape_timeout  = 100
vim.g.python3_host_prog='/usr/bin/python3'
vim.g.python_host_prog='/usr/bin/python'

------------
--Mappings--
------------

vim.g.mapleader= ' '

-- Copy and paste with system clipboard

vim.api.nvim_set_keymap('v', '<C-c>', '"+y',    {noremap = true})
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', {noremap = true})

vim.api.nvim_set_keymap('i', 'jk','<esc>', {noremap = true})
vim.api.nvim_set_keymap('i', 'kj','<esc>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-n>',':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>r',':NvimTreeRefresh<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>n',':NvimTreeFindFile<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<C-s>',':BufferLinePick<CR>', {noremap = true})
vim.api.nvim_set_keymap('c', 'w!!','w !sudo tee > /dev/null %', {noremap = true})
