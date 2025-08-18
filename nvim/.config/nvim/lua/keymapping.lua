-----------
--Mappings--
------------
local keymap = vim.keymap.set
local opts = { silent = true }

local map = vim.keymap.set


-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- buffers
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Copy and paste with system clipboard

keymap('v', '<C-c>', '"+y',    opts)
keymap('i', '<C-v>', '<C-r>+', opts)

keymap('i', 'jk','<esc>', opts)
keymap('i', 'kj','<esc>', opts)


-- Normal --
-- -- Save and quit
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
keymap('n', '<C-n>',':NvimTreeToggle<CR>', opts)
keymap('n', '<leader>r',':NvimTreeRefresh<CR>', opts)
keymap('n', '<leader>n',':NvimTreeFindFile<CR>', opts)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
--keymap('n', '<C-s>',':BufferLinePick<CR>', opts)
--force sudo save
keymap('c', 'w!!','w !sudo tee > /dev/null %', opts)


-- floating terminal
map("n", "<leader>ft", function() Snacks.terminal("zsh") end, { desc = "Terminal (cwd)" })
map("n", "<c-t>", function() Snacks.terminal("zsh") end, { desc = "Terminal (Root Dir)" })

-- Terminal Mappings
map("t", "<c-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

map("n", "<Leader>sr", function()
    require("grug-far").open({
        prefills = {
            paths = vim.fn.expand("%"),
        },
    })
end)
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
map("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })

