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

  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
       vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
      { name = 'calc'},
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
