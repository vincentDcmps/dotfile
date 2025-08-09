return {
    {
        'jvirtanen/vim-hcl',
        event= "VeryLazy"
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
            "https://github.com/MagicDuck/grug-far.nvim",
            lazy = true,
            config = function()
                  require("grug-far").setup({})
              end,
        },
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        cmd = "Telescope",
        keys= {
            { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
            { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
            { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            -- find
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
            { "<leader>fF", function() builtin.find_files({ cwd = utils.buffer_dir() }) end, desc = "Find Files (cwd)" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
            -- git
            { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
            -- search
            { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
            { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
            { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
            { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
            { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
            { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
            { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
            { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        },
        config = function()
            local actions=require 'telescope.actions'
            require 'telescope'.setup({
              mappings = {
                i = {
                    ["<Down>"] =actions.cycle_history_next,
                    ["<Up>"] = actions.cycle_history_prev,
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                n = {
                 ["q"] = function(...)
                 return require("telescope.actions").close(...)
                  end,
                 },
                },
              },
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
        "https://github.com/lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup({
            })
        end,
    },
    {
        'RRethy/vim-illuminate',
    },
    {
        "https://github.com/windwp/nvim-autopairs",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                fast_wrap = {
              },
            })
        end,
    },
    {
      "folke/trouble.nvim",
      cmd = { "TroubleToggle", "Trouble" },
      opts = { use_diagnostic_signs = true },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
    },
}

