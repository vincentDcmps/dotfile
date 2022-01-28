-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/vincent/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/vincent/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/vincent/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/vincent/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/vincent/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["feline.nvim"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/feline.nvim",
    url = "https://github.com/famiu/feline.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\1\2À\3\0\0\6\0\24\00034\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\6\0%\3\a\0003\4\b\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\t\0%\3\n\0003\4\v\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\f\0%\3\r\0004\4\0\0007\4\14\0047\4\15\4%\5\16\0>\4\2\2$\3\4\0033\4\17\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\18\0%\3\19\0003\4\20\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\21\0%\3\22\0003\4\23\0>\0\5\1G\0\1\0\1\0\1\fnoremap\2\17:GFiles!<CR>\15<LEADER>fg\1\0\1\fnoremap\2\r:Rg!<CR>\15<LEADER>f/\1\0\1\fnoremap\2\n%:p:h\vexpand\afn\r:Files! \15<LEADER>f.\1\0\1\fnoremap\2\17:Files!<CR>'\15<LEADER>ff\1\0\1\fnoremap\2\18:Buffers!<CR>\18<LEADER><TAB>\6n\20nvim_set_keymap\bapi\21fzf_buffers_jump\6g\bvim\0" },
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2:\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\1\2‡\1\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\3#show_trailing_blankline_indent\1\28show_first_indent_level\1\tchar\bâ–\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { "\27LJ\1\2\0\0\5\0\a\0\t4\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\4\0%\3\5\0003\4\6\0>\0\5\1G\0\1\0\1\0\2\vsilent\2\fnoremap\2\31:MarkdownPreviewToggle<CR>\15<LEADER>mp\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\2@\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-cursorline"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/nvim-cursorline",
    url = "https://github.com/yamatsum/nvim-cursorline"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\1\2å\1\0\0\5\0\14\0\0194\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\4\0%\3\5\0002\4\0\0>\0\5\0014\0\6\0%\1\a\0>\0\2\0027\0\b\0003\1\t\0003\2\n\0:\2\v\0013\2\f\0:\2\r\1>\0\2\1G\0\1\0\tview\1\0\1\nwidth\3(\24update_focused_file\1\0\1\venable\2\1\0\1\15auto_close\2\nsetup\14nvim-tree\frequire\28<cmd>NvimTreeToggle<cr>\14<leader>t\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-whichkey-setup.lua"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/nvim-whichkey-setup.lua",
    url = "https://github.com/AckslD/nvim-whichkey-setup.lua"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["todo.txt-vim"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/todo.txt-vim",
    url = "https://github.com/freitass/todo.txt-vim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  ["vim-easyescape"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/vim-easyescape",
    url = "https://github.com/zhou13/vim-easyescape"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\1\2v\0\0\3\0\a\0\r4\0\0\0007\0\1\0007\0\2\0%\1\3\0'\2,\1>\0\3\0014\0\4\0%\1\5\0>\0\2\0027\0\6\0002\1\0\0>\0\2\1G\0\1\0\nsetup\14which-key\frequire\15timeoutlen\20nvim_set_option\bapi\bvim\0" },
    loaded = true,
    path = "/home/vincent/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\1\2:\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\1\2v\0\0\3\0\a\0\r4\0\0\0007\0\1\0007\0\2\0%\1\3\0'\2,\1>\0\3\0014\0\4\0%\1\5\0>\0\2\0027\0\6\0002\1\0\0>\0\2\1G\0\1\0\nsetup\14which-key\frequire\15timeoutlen\20nvim_set_option\bapi\bvim\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\1\2å\1\0\0\5\0\14\0\0194\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\4\0%\3\5\0002\4\0\0>\0\5\0014\0\6\0%\1\a\0>\0\2\0027\0\b\0003\1\t\0003\2\n\0:\2\v\0013\2\f\0:\2\r\1>\0\2\1G\0\1\0\tview\1\0\1\nwidth\3(\24update_focused_file\1\0\1\venable\2\1\0\1\15auto_close\2\nsetup\14nvim-tree\frequire\28<cmd>NvimTreeToggle<cr>\14<leader>t\6n\20nvim_set_keymap\bapi\bvim\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\1\2‡\1\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\3#show_trailing_blankline_indent\1\28show_first_indent_level\1\tchar\bâ–\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\1\2@\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
try_loadstring("\27LJ\1\2À\3\0\0\6\0\24\00034\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\6\0%\3\a\0003\4\b\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\t\0%\3\n\0003\4\v\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\f\0%\3\r\0004\4\0\0007\4\14\0047\4\15\4%\5\16\0>\4\2\2$\3\4\0033\4\17\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\18\0%\3\19\0003\4\20\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\21\0%\3\22\0003\4\23\0>\0\5\1G\0\1\0\1\0\1\fnoremap\2\17:GFiles!<CR>\15<LEADER>fg\1\0\1\fnoremap\2\r:Rg!<CR>\15<LEADER>f/\1\0\1\fnoremap\2\n%:p:h\vexpand\afn\r:Files! \15<LEADER>f.\1\0\1\fnoremap\2\17:Files!<CR>'\15<LEADER>ff\1\0\1\fnoremap\2\18:Buffers!<CR>\18<LEADER><TAB>\6n\20nvim_set_keymap\bapi\21fzf_buffers_jump\6g\bvim\0", "config", "fzf.vim")
time([[Config for fzf.vim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
