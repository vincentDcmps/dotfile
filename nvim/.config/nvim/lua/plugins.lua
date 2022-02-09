
-------------
-- Plugins --
-------------

-- Auto install plugin manager

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup {
  function(use)


    use 'wbthomason/packer.nvim'

    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup({
        })
      end
    }

   use 'ellisonleao/gruvbox.nvim'


   use 'zhou13/vim-easyescape'


   use {
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install'](0)
      end,
      ft = {
        'markdown'
      },
      config = function()
        vim.api.nvim_set_keymap('n', '<LEADER>mp', ':MarkdownPreviewToggle<CR>', {noremap = true, silent = true})
      end
    }

    -- Fuzzy search
    use {
      'junegunn/fzf.vim',
      requires = {
        'junegunn/fzf'
      },
      config = function()
        vim.g.fzf_buffers_jump = 1
        vim.api.nvim_set_keymap('n', '<LEADER><TAB>', ':Buffers!<CR>', {noremap = true})
        vim.api.nvim_set_keymap('n', '<LEADER>ff', ':Files!<CR>\'', {noremap = true})
        vim.api.nvim_set_keymap('n', '<LEADER>f.', ':Files! '..vim.fn.expand('%:p:h'), {noremap = true})
        vim.api.nvim_set_keymap('n', '<LEADER>f/', ':Rg!<CR>', {noremap = true})
        vim.api.nvim_set_keymap('n', '<LEADER>fg', ':GFiles!<CR>', {noremap = true})
      end
    }

    -- Show indent line
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup {
          char = "▏",
          show_first_indent_level = false,
          show_trailing_blankline_indent = false,
        }
      end
    }
   -- Language server protocol
    use {
      'williamboman/nvim-lsp-installer',
      requires = {
        'neovim/nvim-lspconfig',
      },
      run = function()
        local required_servers = {
          "ansiblels",
          "bashls",
          "diagnosticls",
          "dockerls",
          "jsonls",
          "pylsp",
          "pyright",
          "sqls",
          "yamlls",
          "remark_ls",
        }

        require "nvim-lsp-installer.ui.status-win"().open()
        local lsp_installer_servers = require'nvim-lsp-installer.servers'
        for _, required_server in pairs(required_servers) do
          local _, server = lsp_installer_servers.get_server(required_server)
          if not server:is_installed() then
            server:install()
          end
        end
      end,
      config = function()
        local lsp_installer = require("nvim-lsp-installer")

        lsp_installer.on_server_ready(function(server)
          local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            --Enable completion triggered by <c-x><c-o>
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local opts = { noremap=true, silent=true }

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
            buf_set_keymap('n', '<space>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
          end

          server:setup({
            on_attach = on_attach()
          })

          vim.cmd [[ do User LspAttachBuffers ]]
        end)
      end
    }
  -- Autocomplete
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        -- sources
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-calc',


        -- snippets
        'SirVer/ultisnips',
        -- pictograms
        'onsails/lspkind-nvim'
      }
    }

  use({'jose-elias-alvarez/null-ls.nvim',
        config= function()
          require("null-ls").setup({
           on_attach = function(client)
            if client.resolved_capabilities.document_formatting then
              vim.cmd([[
              augroup LspFormatting
                  autocmd! * <buffer>
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
               augroup END
              ]])
            end
          end,
        sources = {
          require("null-ls").builtins.formatting.prettier,
          require("null-ls").builtins.formatting.trim_whitespace,
          require("null-ls").builtins.formatting.trim_newlines,
          require("null-ls").builtins.formatting.black,
          require("null-ls").builtins.diagnostics.eslint,
          require("null-ls").builtins.diagnostics.ansiblelint,
          require("null-ls").builtins.completion.spell,
          },
        })
        end})

	-- File manager
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", {})
			require("nvim-tree").setup({
				auto_close = true,
				update_focused_file = {
					enable = true,
				},
				view = {
					width = 40,
				},
			})
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			vim.api.nvim_set_option("timeoutlen", 300)
			require("which-key").setup({})
		end,
	})

  use 'AckslD/nvim-whichkey-setup.lua'

  use 'yamatsum/nvim-cursorline'
  use 'freitass/todo.txt-vim'

  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    keys = {
      '<LEADER>gs'
    },
    cmd = {
      'Neogit'
    },
    config = function()
      require('neogit').setup {
        disable_commit_confirmation = true,
        disable_context_highlighting = true
      }

        vim.api.nvim_set_keymap('n', '<LEADER>gs', ':Neogit kind=split<CR>', {noremap = true})
      end
    }
  use ({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{
        fast_wrap= {},
      }
    end
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true
        }
    }
    end
  })

  use {
    'akinsho/bufferline.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require('bufferline').setup{
        options = {
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
              text_align = 'left'
            }
          }
        }
      }
      vim.api.nvim_set_keymap('n', '<C-l>', ':BufferLineCycleNext<CR>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<C-h>', ':BufferLineCyclePrev<CR>', {noremap = true})
    end
    }
  use {'feline-nvim/feline.nvim',
    config = function()
      require('feline').setup({})
    end
  }
  use {'sheerun/vim-polyglot'}
  if packer_bootstrap then
      require('packer').sync()
    end
  end
}
