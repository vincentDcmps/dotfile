
-------------
-- Plugins --
-------------
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Auto install plugin manager

local fn = vim.fn

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()



return require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('plugins.gitsign')
      end
    }

  use 'ellisonleao/gruvbox.nvim'
  -- Show indent line
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
    require('plugins.indent-blankline')

    end
  }

  --LSP
  use({ "https://github.com/neovim/nvim-lspconfig"})
  use({ "https://github.com/williamboman/mason-lspconfig.nvim"})
  use({ "https://github.com/williamboman/mason.nvim",
    config= function()
    end
  })
  use({ "https://github.com/jose-elias-alvarez/null-ls.nvim",
    config= function()
      require('plugins.lsp.null-ls')
    end
  })

  use {
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install'](0)
      end,
      config = function()
      end,
  }



   -- telescope
   use {
     'nvim-telescope/telescope.nvim',
   }
   use {
     'nvim-telescope/telescope-fzf-native.nvim',
     run = 'make',
     config = function()
       require ('plugins.telescope')
     end
   }


   use {
    'zhou13/vim-easyescape',
    config = function()
       require('plugins.vim-easyescape')
    end
  }



  -- Autocomplete
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-calc'
    use 'hrsh7th/cmp-git'
    use 'hrsh7th/cmp-nvim-lua'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    use 'onsails/lspkind-nvim'


    use({
      'hrsh7th/nvim-cmp',
      config= function()
        require('plugins.cmp')
      end
    })

	-- UI
    use 'kyazdani42/nvim-web-devicons'
    use {
      'akinsho/bufferline.nvim',
      config = function()
        require('plugins.bufferline')
      end
    }
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
          require('plugins.nvim-tree')
		end,
	})

    use 'AckslD/nvim-whichkey-setup.lua'
	use({
		"folke/which-key.nvim",
		config = function()
          require('plugins.which-key')
		end,
	})


  --use 'freitass/todo.txt-vim'
  use 'nvim-lua/plenary.nvim'
  use {
    'TimUntersberger/neogit',
    config = function()
      require('plugins.neogit')
    end
    }
  use ({
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end
  })
  
  --treesitter
  use 'RRethy/nvim-treesitter-endwise'
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('plugins.treesitter')
    end
  })


  use {'feline-nvim/feline.nvim',
    config = function()
      require('feline').setup({})
    end
  }
  if packer_bootstrap then
      require('packer').sync()
    end
  end
}
