
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

        -- snippets
        'SirVer/ultisnips',
        -- pictograms
        'onsails/lspkind-nvim'
      }
    }

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

  use 'famiu/feline.nvim'
  use 'yamatsum/nvim-cursorline'
  use 'freitass/todo.txt-vim'
  
  use 'tpope/vim-fugitive'

  use ({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
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
    'akinsho/nvim-bufferline.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require("bufferline").setup({})
    end
    }
  use 'romgrk/barbar.vim'
  if packer_bootstrap then
      require('packer').sync()
    end
  end 
}


