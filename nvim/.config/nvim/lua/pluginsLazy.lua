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

return require("lazy").setup({
    {
        "https://github.com/nvim-lua/plenary.nvim",
        cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
        lazy = true,
    },
    {
        'tpope/vim-eunuch',
        event= "VeryLazy"
    },
    {
        "https://github.com/williamboman/mason-lspconfig.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "https://github.com/williamboman/mason.nvim",
            "https://github.com/neovim/nvim-lspconfig",
        },
        config = function()
            require('plugins.lsp.mason')

        end
    },
    {
        "https://github.com/jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        config = function()
            require "null-ls".setup({
                debug = false,
                sources = {
                    formatting.prettier.with({
                        extra_filetypes = { "toml" },
                        extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
                    }),
                    formatting.black.with({ extra_args = { "--fast" } }),
                    formatting.stylua,
                    formatting.google_java_format,
                    diagnostics.flake8,
                    diagnostics.eslint,
                    diagnostics.markdownlint,
                },
            })
        end
    },
    {
        "https://github.com/iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && yarn install",
        setup= function ()
            require("markdown-preview").setup({})
            vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>", { silent = true })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        cmd = "Telescope",
        config = function()
            require 'telescope'.setup({
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            })
            local opts = { silent = true }
            vim.keymap.set("n", "<leader><leader>", ":Telescope git_files<CR>", opts)
            vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
            vim.keymap.set("n", "<leader>fF", function() builtin.find_files({ cwd = utils.buffer_dir() }) end, opts)
            vim.keymap.set("n", "<leader>/", ":Telescope live_grep<CR>", opts)
            vim.keymap.set("n", "<leader>pp", ":Telescope projects<CR>", opts)
            vim.keymap.set("n", "<leader>,", ":Telescope buffers<CR>", opts)
        end

    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        lazy = true,
        build = 'make',
     },
    {
        'zhou13/vim-easyescape',
        config = function()
            vim.g.easyescape_chars   = {
                j = 0,
                k = 0
            }
            vim.g.easyescape_timeout = 99
        end
    },
    {
        "https://github.com/hrsh7th/nvim-cmp",
        event = "VeryLazy",
        dependencies = {
            "https://github.com/hrsh7th/cmp-buffer",
            "https://github.com/hrsh7th/cmp-nvim-lsp",
            "https://github.com/hrsh7th/cmp-path",
            "https://github.com/saadparwaiz1/cmp_luasnip",
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-git',
            'hrsh7th/cmp-nvim-lua',
            'rafamadriz/friendly-snippets',
            'onsails/lspkind-nvim',
            "https://github.com/L3MON4D3/LuaSnip",

        },
        config = function()
            require('plugins.cmp')
        end
    },
    {
        'ellisonleao/gruvbox.nvim',
        event = "VeryLazy",
    },
    {
        "https://github.com/lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                show_first_indent_level = false,
                show_trailing_blankline_indent = false,
                use_treesitter = true,
            })
        end,
    },
    {
        'kyazdani42/nvim-web-devicons'
    },
    {
        "https://github.com/akinsho/bufferline.nvim",
        event = "VeryLazy",
        config = function()
            require("bufferline").setup({
                options = {
                    always_show_bufferline = false,
                },
            })
        end,
    },
    {
        "kyazdani42/nvim-tree.lua",
        event = "VeryLazy",
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                view = {
                    width = 30,
                    side = "left",
                },
            })
        end
    },
    {
        'AckslD/nvim-whichkey-setup.lua',
        event = "VeryLazy",
    },
    {
        "https://github.com/folke/which-key.nvim",
        lazy = true,
        config = function()
            require("which-key").setup({})
            vim.api.nvim_set_option("timeoutlen", 300)
        end,
        cmd = "WhichKey",
        event = "VeryLazy",
    },
    {
        "https://github.com/nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                },
            })
        end,
    },
    {
        "https://github.com/j-hui/fidget.nvim",
        tag = "legacy", -- TODO https://github.com/j-hui/fidget.nvim/issues/131
        event = "VeryLazy",
        config = function()
            require("fidget").setup({
                text = {
                    spinner = "dots",
                },
            })
        end,
    },
    {
        "https://github.com/lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
            })
        end,
    },
    {
        'RRethy/vim-illuminate',
    },
    {
        "https://github.com/NeogitOrg/neogit",
        cmd = "Neogit",
        config = function()
            require("neogit").setup({
                disable_commit_confirmation = true,
                kind = "split",
                integrations = {
                    diffview = true,
                },
            })
            vim.keymap.set('n', '<LEADER>gs', ':Neogit kind=split<CR>', { silent = true })
        end,
    },
    {
        "https://github.com/windwp/nvim-autopairs",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
            })
        end,
    },
    { 'RRethy/nvim-treesitter-endwise'
    },
    {
        "https://github.com/nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "dockerfile",
                    "gitcommit",
                    "go",
                    "hcl",
                    "javascript",
                    "json",
                    "json5",
                    "jsonnet",
                    "latex",
                    "lua",
                    "nix",
                    "markdown",
                    "proto",
                    "python",
                    "rego",
                    "rust",
                    "terraform",
                    "typescript",
                    "yaml",
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                endwise = {
                    enable = true,
                },
            })
            vim.treesitter.language.register("nomad", "hcl")
        end,
    },
    {
        "https://github.com/mfussenegger/nvim-dap",
          dependencies = {
             { "rcarriga/nvim-dap-ui" },
             { "theHamsta/nvim-dap-virtual-text" },
        },
    },
})
