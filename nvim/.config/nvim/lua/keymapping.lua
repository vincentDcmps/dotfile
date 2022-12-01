-----------
--Mappings--
------------
local keymap = vim.keymap.set
local opts = { silent = true }

vim.g.mapleader= ' '

-- Copy and paste with system clipboard

keymap('v', '<C-c>', '"+y',    opts)
keymap('i', '<C-v>', '<C-r>+', opts)

keymap('i', 'jk','<esc>', opts)
keymap('i', 'kj','<esc>', opts)


-- Normal --
-- -- Save and quit
keymap("n", "<C-s>", ":write<cr>", opts)
keymap("n", "<C-q>", ":quit<cr>", opts)
keymap('n', '<C-n>',':NvimTreeToggle<CR>', opts)
keymap('n', '<leader>r',':NvimTreeRefresh<CR>', opts)
keymap('n', '<leader>n',':NvimTreeFindFile<CR>', opts)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- Navigate buffers
keymap("n", "<C-l>", ":bnext<CR>", opts)
keymap("n", "<C-h>", ":bprevious<CR>", opts)


--keymap('n', '<C-s>',':BufferLinePick<CR>', opts)
--force sudo save
keymap('c', 'w!!','w !sudo tee > /dev/null %', opts)

require('plugins.markdown-preview')
